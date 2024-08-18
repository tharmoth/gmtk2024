extends Area2D

const FIRST_CORNER = 0.18
const SECOND_CORNER = 0.5
const THIRD_CORNER = 0.68

@export
var max_rocks = 10

@export
var max_small_rocks = 30

var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = 1.0
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_spawn)
	call_deferred("add_child", timer)

func _spawn() -> void:
	timer.wait_time = randf_range(1.0, 5.0)
	
	if len(get_tree().get_nodes_in_group("rock")) - 1 >= max_rocks or len(get_tree().get_nodes_in_group("small_rock")) > max_small_rocks:
		return
	
	var rock_scene : PackedScene = load("res://src/rock.tscn")
	var rock : Node2D = rock_scene.instantiate()
	
	var rock_spawn_location = $RockSpawnPath/RockFollowLocation
	
	decide_rock_position()
	rock.position = rock_spawn_location.position
	
	rock.scale = Vector2.ZERO
	var tween = rock.create_tween()
	tween.tween_property(rock, "scale", Vector2.ONE * randf_range(.5, 1.5), .25)
	
	add_sibling(rock)

func decide_rock_position():
	var rock_spawn_location = $RockSpawnPath/RockFollowLocation
	var old_progress_ratio = rock_spawn_location.progress_ratio
	print(old_progress_ratio)
	
	if old_progress_ratio >= 0.0 and  old_progress_ratio <= FIRST_CORNER:
		print("First Range!")
		rock_spawn_location.progress_ratio = randf_range(FIRST_CORNER, 1.0)
	elif old_progress_ratio >= FIRST_CORNER and old_progress_ratio <= SECOND_CORNER:
		print("Second Range!")
		if randi_range(1 , 3) == 1:
			rock_spawn_location.progress_ratio = randf_range(0.0, FIRST_CORNER)
		else:
			rock_spawn_location.progress_ratio = randf_range(SECOND_CORNER, 1)
	elif old_progress_ratio >= SECOND_CORNER and old_progress_ratio <= THIRD_CORNER:
		print("Third Range!")
		if randi_range(1 , 3) == 3:
			rock_spawn_location.progress_ratio = randf_range(0.0, SECOND_CORNER)
		else:
			rock_spawn_location.progress_ratio = randf_range(THIRD_CORNER, 1)
	else:
		print("Fourth Range!")
		rock_spawn_location.progress_ratio = randf_range(0.0, THIRD_CORNER)
