extends Area2D

@export
var max_rocks = 10

@export
var max_small_rocks = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_spawn)
	call_deferred("add_child", timer)

func _spawn() -> void:
	var children = get_children()
	if len(get_tree().get_nodes_in_group("rock")) - 1 >= max_rocks or len(get_tree().get_nodes_in_group("small_rock")) > max_small_rocks:
		return
	
	var rock_scene : PackedScene = load("res://src/rock.tscn")
	var rock : Node2D = rock_scene.instantiate()
	
	var rock_spawn_location = $RockSpawnPath/RockFollowLocation
	rock_spawn_location.progress_ratio = randf()
	rock.position = rock_spawn_location.position
	
	rock.scale = Vector2.ZERO
	var tween = rock.create_tween()
	tween.tween_property(rock, "scale", Vector2.ONE * randf_range(.5, 1.5), .25)
	
	add_sibling(rock)
