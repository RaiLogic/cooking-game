extends Node

# THIS AUTOLOAD SCRIPT IS ONLY FOR INPUT THAT IS USED BY BOTH PLAYERS TO AVOID
# CALLING THE ACTION TWICE

signal order_pressed

func _process(delta: float) -> void:
	# GLOBAL INPUTS FOR RESTAURANT SCENE
	if global.current_location == global.LOCATIONS.RESTAURANT:
		if Input.is_action_just_pressed("escape"):
			pause.pause_game()
		if Input.is_action_just_pressed("checkmenu"):
			order_pressed.emit()
			
	if global.current_location == global.LOCATIONS.HOUSE:
		if Input.is_action_just_pressed("escape"):
			pause.pause_game()
