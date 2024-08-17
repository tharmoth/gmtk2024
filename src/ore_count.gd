extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var production : float = 0.0
	for building_button : BuildingButton in %BuildingButtons.get_children():
		production += building_button.production * building_button.count
		
	text = str(int(Main.ore)) + " Ore\nper second: " + str(int(production))
