extends Node2D

var rotate : float = randf_range(-30, 30)

func _ready() -> void:
	$Area2D.input_event.connect(_clicked)
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position", global_position + Vector2(0, 20), 1.2)
	tween.tween_property(self, "global_position", global_position, 1.2)
	tween.set_loops()
	
func _clicked(_viewport, event : InputEvent, _shape_idx) -> void:
	if event.is_action_pressed("left_click"):
		queue_free()
		Main.ore += 10;
		FloatingLabel.Show("+10", global_position, get_tree().root)

func _process(delta: float) -> void:
	rotation_degrees += delta * rotate
