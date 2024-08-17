class_name BuildingButton extends Button

@export
var cost : float = 100.0
@export
var production : float = 1.0
var count : int = 0
var _type : String

func _ready() -> void:
	_type = text
	_update()

func _pressed() -> void:
	if Main.ore >= cost:
		Main.ore -= cost
		cost *= 1.1
		count += 1
		_update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	disabled = Main.ore < cost
	Main.ore += count * production * delta

func _update() -> void:
	text = _type + "\nCount: " + str(count)  + "\nCost: " + str(int(cost))
