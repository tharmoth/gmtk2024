class_name FloatingLabel

static func Show(text: String, global_position: Vector2, parent : Node):
	var label := RichTextLabel.new()
	label.autowrap_mode = TextServer.AUTOWRAP_OFF
	label.custom_minimum_size = Vector2.ONE * 1000
	
	label.text = "[font_size=10]" + text + "[/font_size]"
	label.global_position = global_position
	label.bbcode_enabled = true
	label.z_index = 100
	label.mouse_filter = Control.MouseFilter.MOUSE_FILTER_IGNORE
	
	parent.add_child(label)
	
	var text_pos_tween = label.create_tween()
	text_pos_tween.tween_property(label, "global_position", label.global_position + Vector2(0, -50), 1.0)
	text_pos_tween.tween_callback(func(): label.queue_free())
	
	var text_color_tween = label.create_tween()
	text_color_tween.tween_property(label, "modulate", Color(1, 1, 1, 0), 1.0)
