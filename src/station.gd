extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		_draw_line(global_position, get_global_mouse_position())
		%LaserPlayer.play()

func _draw_line(from: Vector2, to: Vector2) -> void:
	var line : Line2D = Line2D.new()
	line.points = [from, to]
	line.width = 0
	line.default_color = Color(10, 0, 0, 1)
	add_sibling(line)

	var laser_tween : Tween = get_parent().get_tree().create_tween()
	laser_tween.tween_property(line, "width", 6, .05)
	laser_tween.tween_property(line, "width", 0, .3)
	laser_tween.tween_callback(func() -> void: line.queue_free())
