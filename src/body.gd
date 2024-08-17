extends Node2D

var legs : Array[Vector2] = [Vector2.UP * 50,  Vector2.LEFT * 50, Vector2.RIGHT * 50]
var targets : Array[Vector2] = [Vector2.UP * 50,  Vector2.LEFT * 50, Vector2.RIGHT * 50]
var current : int = 0
var click : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(len(legs)):
		legs[i] += global_position
	
	global_position = _get_center()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	if Input.is_action_just_pressed("left_click"):
		click = get_global_mouse_position()
		targets[current] = get_global_mouse_position()
		current += 1
		if current >= len(legs):
			current = 0
			
	for i in range(len(legs)):
		legs[i] = lerp(legs[i], targets[i], delta * 5)
		


	global_position = _get_center()

func _draw() -> void:
	draw_circle(to_local(click), 5, Color.DARK_BLUE)
	for i in range(len(legs)):
		var leg : Vector2 = legs[i]
		var color : Color = Color.RED
		if i == current:
			color = Color.RED.lightened(.5)
			
		draw_circle(to_local(leg), 10, color)
	draw_circle(to_local(global_position), 10, Color.RED.darkened(10))
	

func _get_center() -> Vector2:
	var center : Vector2
	for leg in legs:
		center += leg / len(legs)
	return center
