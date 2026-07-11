class_name InputComponent extends Node

var move_action: Vector2 = Vector2.ZERO
var dashed: bool = false
var interact: bool = false
var dance_move: bool = false

var controls: bool = true

@export var move_up : String
@export var move_down : String
@export var move_left : String
@export var move_right : String

@export var dash : String
@export var action : String
@export var dance : String

func get_input() -> void:
	if controls:
		move_action = Input.get_vector(
			move_left, 
			move_right, 
			move_up, 
			move_down
			)
			
		dashed = Input.is_action_just_pressed(dash)
		interact = Input.is_action_just_pressed(action)
		dance_move = Input.is_action_just_pressed(dance)
