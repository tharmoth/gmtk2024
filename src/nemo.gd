extends Node2D

var target : Node2D
var fuel_per_second : float = 1.0
var rotate : float = randf_range(-20, 20)
var speed : float = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_instance_valid(target):
		rotation_degrees += delta * rotate
		target = _get_target()
		return
	
	if Main.fuel < fuel_per_second * delta:
		rotation_degrees += delta * rotate
		return
	Main.fuel -= fuel_per_second * delta
	
	if global_position.distance_to(target.global_position) < 50 * target.scale.x:
		target.collect()
		return
	
	var direction = global_position.direction_to(target.global_position)
	global_position += direction * delta * speed

	rotation = lerp_angle(rotation, global_position.angle_to_point(target.global_position), 5 * delta)

func _get_target() -> Node2D:
	var nodes = get_tree().get_nodes_in_group("small_rock")
	if len(nodes) <= 0:
		return
	return nodes[randi_range(0, len(nodes) - 1)]
