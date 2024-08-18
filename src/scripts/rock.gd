class_name Rock extends Node2D

var rotate : float = randf_range(-30, 30)
var health : float = randi_range(2, 5)

var angle : float
var speed : float = randf_range(0.3, 0.8)

func _ready() -> void:
	$Area2D.input_event.connect(_clicked)
	var screen_center : Vector2 = get_viewport_rect().size / 2
	angle = remap(get_angle_to(screen_center), -PI, PI, 0, 2*PI)
	angle = angle-PI/8 if randi() % 2 else angle+PI/8
	
	#var tween = create_tween()
	#tween.set_ease(Tween.EASE_IN_OUT)
	#tween.set_trans(Tween.TRANS_SINE)
	#tween.tween_property($Sprite2D, "position", Vector2.UP * 20, 1.2)
	#tween.tween_property($Sprite2D, "position", Vector2.ZERO, 1.2)
	#tween.set_loops()
	add_to_group("rock")

func _clicked(_viewport, event : InputEvent, _shape_idx) -> void:
	if event.is_action_pressed("left_click"):
		health -= 1
		var tween = create_tween()
		tween.tween_property(self, "modulate", Color(10, 10, 10, 10), .05)
		tween.tween_property(self, "modulate", Color.WHITE, .05)
		if health <= 0:
			collect()

func collect() -> void:
	queue_free()
	for i in range(randi_range(1, 5)):
		_break_apart()

func _break_apart() -> void:
	var rock_scene : PackedScene = load("res://src/scenes/smallrock.tscn")
	var rock : Node2D = rock_scene.instantiate()

	var x : float = randf_range(-20, 20)
	var y : float = randf_range(-20, 20)
	
	var pos = Vector2(x, y) + position
	
	rock.position = pos
	rock.scale = Vector2.ZERO
	rock.rotation_degrees = randf_range(0, 360)
	var tween = rock.create_tween()
	tween.tween_property(rock, "scale", Vector2.ONE * randf_range(.1, .2), .25)
	
	add_sibling(rock)
	
	Main.shake()

func _on_visible_on_screen_notifier_2d_screen_exited():
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.one_shot = true
	timer.timeout.connect(_remove_rock)
	call_deferred("add_child", timer)

func _remove_rock():
	queue_free()

func _process(delta: float) -> void:
	rotation_degrees += delta * rotate

func _physics_process(delta):
	position -= Vector2(1, 0).rotated(angle) * speed
