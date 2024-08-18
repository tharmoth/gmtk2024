extends Button

@export
var cost : float = 200.0
@export
var production : float = 1.0
var count : int = 0
var refine_amount : int = 0
var _type : String

func _ready() -> void:
	_type = text
	_update()
	
	var timer = Timer.new()
	timer.wait_time = 1
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_refine_fuel)
	call_deferred("add_child", timer)

func _process(delta: float) -> void:
	visible = %HaulerButton.count > 0
	disabled = Main.ore < cost

func _pressed() -> void:
	if Main.ore >= cost:
		Main.ore -= cost
		refine_amount += 1
		cost *= 1.5
		count += 1
		#Main.fuel += 1000.0
		_update()
	
func _refine_fuel() -> void:
	
	if Main.ore >= refine_amount and Main.fuel < 1000:
		Main.ore -= refine_amount
		Main.fuel += refine_amount * 10
	#cost = randi_range(200, 1000)
	#_update()

func _update() -> void:
	text = _type + "\nCount: " + str(count) + "\nCost: " + str(int(cost))
