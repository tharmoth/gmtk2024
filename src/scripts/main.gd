class_name Main extends Node2D

static var ore : float = 0.0
static var fuel : float = 300.0

static var occupied_hangar_space : int = 0
static var total_hangar_space : int = 1

static var _instance : Main

func _ready() -> void:
	_instance = self
	
static func shake() -> void:
	_instance._shake()
	
static func available_hangar_space():
	return total_hangar_space - occupied_hangar_space

func _shake() -> void:
	%ShakeCameraPlayer.play("shake")
