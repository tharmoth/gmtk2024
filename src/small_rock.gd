class_name SmallRock extends Node2D

var rotate : float = randf_range(-30, 30)
var collecting : bool = false

func _ready() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($Sprite2D, "position", Vector2.UP * 20, 1.2)
	tween.tween_property($Sprite2D, "position", Vector2.ZERO, 1.2)
	tween.set_loops()
	
	add_to_group("small_rock")
	
	#$Area2D.input_event.connect(_clicked)

func _process(delta: float) -> void:
	rotation_degrees += delta * rotate
	if collecting:
		var direction = global_position.direction_to(Station.instance.global_position)
		global_position += direction * delta * 200
		
		if global_position.distance_to(Station.instance.global_position) < 10:
			var amount : int = randi_range(5, 15)
			Main.ore += amount
			FloatingLabel.Show("+" + str(amount), global_position, get_tree().root)
			queue_free()

################################################################################
## Public Methods                                                             ##
################################################################################
func collect() -> void:
	collecting = true

################################################################################
## Private Methods                                                            ##
################################################################################
func _clicked(_viewport, event : InputEvent, _shape_idx) -> void:
	if event.is_action_pressed("left_click"):
		collect()
