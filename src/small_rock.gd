extends Node2D

var rotate : float = randf_range(-30, 30)

func _ready() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position", global_position + Vector2(0, 20), 1.2)
	tween.tween_property(self, "global_position", global_position, 1.2)
	tween.set_loops()
	
	add_to_group("small_rock")
	
	$Area2D.input_event.connect(_clicked)

func _process(delta: float) -> void:
	rotation_degrees += delta * rotate

################################################################################
## Public Methods                                                             ##
################################################################################
func collect() -> void:
	var amount : int = randi_range(5, 15)
	Main.ore += amount
	FloatingLabel.Show("+" + str(amount), global_position, get_tree().root)
	queue_free()

################################################################################
## Private Methods                                                            ##
################################################################################
func _clicked(_viewport, event : InputEvent, _shape_idx) -> void:
	if event.is_action_pressed("left_click"):
		collect()
