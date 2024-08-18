extends Label

var last : float= 0
var _samples : Array[float] = []
var seconds_to_sample : float = 30
var samples_per_second : int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = 1.0 / samples_per_second
	timer.timeout.connect(_sample)
	call_deferred("add_child", timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var output : String = ""
	
	output += str(int(Main.ore)) + " Ore\n"

	var sum : float = 0
	for value in _samples:
		sum += value
	sum = sum / seconds_to_sample
	output += str(int(sum)) + " Ore Per Second\n"

	if %HaulerButton.count > 0:
		output += "Fuel: " + str(int(Main.fuel)) + "\n"
		
	
	text = output

func _sample() -> void:
	var current = Main.ore
	if current < last:
		last = current
		return
	
	_samples.append(current - last)
	last = current
	if len(_samples) > seconds_to_sample * samples_per_second:
		_samples.remove_at(0)
