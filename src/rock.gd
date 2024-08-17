extends Node2D

var rotate : float = randf_range(-30, 30)
var health : float = randi_range(2, 5)

func _ready() -> void:
	$Area2D.input_event.connect(_clicked)
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position", global_position + Vector2(0, 20), 1.2)
	tween.tween_property(self, "global_position", global_position, 1.2)
	tween.set_loops()
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
	var rock_scene : PackedScene = load("res://src/smallrock.tscn")
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

func _process(delta: float) -> void:
	rotation_degrees += delta * rotate
