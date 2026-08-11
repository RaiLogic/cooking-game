extends Node

signal order_pressed

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		pause.pause_game()
	if Input.is_action_just_pressed("checkmenu"):
		order_pressed.emit()
