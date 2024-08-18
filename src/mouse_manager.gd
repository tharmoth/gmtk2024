class_name MouseManager extends Node

static var _instance : MouseManager

var stack : Array[Area2D] = []

func _ready() -> void:
	_instance = self
	
static func add(area: Area2D) -> void:
	_instance.stack.append(area)
	
static func remove(area: Area2D) -> void:
	_instance.stack.erase(area)
	
static func peek() -> Area2D:
	if len(_instance.stack) == 0:
		return null
	return _instance.stack[0]
