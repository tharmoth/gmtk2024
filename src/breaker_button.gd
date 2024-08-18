class_name BreakerButton extends Button

@export
var cost : float = 1500.0
@export
var production : float = 1.0
var count : int = 0
var _type : String
var _timer : Timer = Timer.new()

func _ready() -> void:
	_type = text
	_update()
	
	_timer.autostart = false
	_timer.one_shot = false
	_timer.wait_time = 1
	_timer.timeout.connect(_collect_ore)
	#call_deferred("add_child", _timer)
	
	visible = false

func _pressed() -> void:
	if Main.ore >= cost:
		Main.ore -= cost
		cost *= 1.72
		count += 1
		_update()
		_timer.wait_time = 5 / count
		
		_timer.start()
		
		var scene = preload("res://src/hulk.tscn")
		var ship = scene.instantiate()
		ship.position = Station.instance.global_position
		Station.instance.add_sibling(ship)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visible = Main.ore > cost / 10 or count > 0 or visible
	disabled = Main.ore < cost

func _update() -> void:
	text = _type + "\nCount: " + str(count)  + "\nCost: " + str(int(cost))
	
func _collect_ore() -> void:
	var nodes = get_tree().get_nodes_in_group("rock")
	if len(nodes) <= 0:
		return
	if Main.fuel < 50:
		return
	Main.fuel -= 50
	var node = nodes[randi_range(0, len(nodes) - 1)]
	node.collect()
