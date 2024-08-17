class_name Main extends Node2D

static var ore : float = 0.0
static var fuel : float = 1000.0

static var _instance : Main

func _ready() -> void:
	_instance = self
	
static func shake() -> void:
	_instance._shake()

func _shake() -> void:
	%ShakeCameraPlayer.play("shake")
