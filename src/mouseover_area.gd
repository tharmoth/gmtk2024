extends Area2D

func _mouse_enter() -> void:
	MouseManager.add(self)
	
func _mouse_exit() -> void:
	MouseManager.remove(self)

func _exit_tree() -> void:
	MouseManager.remove(self)
