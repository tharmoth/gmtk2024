extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var output : String = ""
	
	output += str(int(Main.ore)) + " Ore\n"

	if %HaulerButton.count > 0:
		output += "Fuel: " + str(int(Main.fuel)) + "\n"
	
	text = output
