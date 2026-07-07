class_name InputComponent extends Node

var move_action: Vector2 = Vector2.ZERO
var dashed: bool = false
var interact: bool = false

func get_input() -> void:
	move_action = Input.get_vector("left", "right", "up", "down")
	dashed = Input.is_action_just_pressed("dash")
	interact = Input.is_action_just_pressed("interact")
