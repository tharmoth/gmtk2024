extends Node2D

var velocity : Vector2 = Vector2.ZERO
var rotational_velocity_degrees : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees += rotational_velocity_degrees * delta
	global_position += velocity * delta
	
	if Input.is_action_pressed("forward"):
		velocity += Vector2.RIGHT.rotated(rotation)
		
	if Input.is_action_pressed("turn_left"):
		rotational_velocity_degrees -= 20 * delta
		
	if Input.is_action_pressed("turn_right"):
		rotational_velocity_degrees += 20 * delta
		
	if Input.is_action_pressed("stop"):
		velocity = lerp(velocity, Vector2.ZERO, delta)
		rotational_velocity_degrees = lerp(rotational_velocity_degrees, 0.0, delta)
