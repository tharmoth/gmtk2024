extends Button

@export
var cost : float = 100.0
@export
var production : float = 1.0
var count : int = 0
var _type : String

func _ready() -> void:
	_type = text
	_update_prices()
	
	var timer = Timer.new()
	timer.wait_time = 3.33
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_update_prices)
	call_deferred("add_child", timer)

func _process(delta: float) -> void:
	visible = %HaulerButton.count > 0
	disabled = Main.ore < cost

func _pressed() -> void:
	if Main.ore >= cost:
		Main.ore -= cost
		Main.fuel += 1000.0
		_update()
		
func _update() -> void:
	text = _type + "\nCost: " + str(int(cost))
	
func _update_prices() -> void:
	cost = randi_range(200, 1000)
	_update()
