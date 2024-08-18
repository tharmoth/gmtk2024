class_name HangarButton extends Button

@export
var cost : float = 100.0
@export
var production : float = 1.0
var _type : String
var _timer : Timer = Timer.new()

var enabled = false

func _ready() -> void:
	_type = text
	_update()

func _pressed() -> void:
	if Main.ore >= cost:
		Main.ore -= cost
		Main.total_hangar_space += 1
		_update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visible = Main.ore > cost or Main.total_hangar_space > 1 or enabled
	if visible:
		enabled = true
	disabled = Main.ore < cost

func _update() -> void:
	text = _type + "\nSpace: " + str(Main.occupied_hangar_space) + "/" + str(Main.total_hangar_space) \
	 + "\nCost: " + str(int(cost))
