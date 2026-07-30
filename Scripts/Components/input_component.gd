class_name InputComponent extends Node

var move_action: Vector2 = Vector2.ZERO
var dashed: bool = false
var interact: bool = false
var dance_move: bool = false

# FOR DELAYING WHEN PRESSING A BUTTON THAT CHANGES THE STATE
# TO ALSO TURN OFF ALL INPUT WHEN FALSE
var controls: bool = true

enum STATES {
	NORMAL,
	FRIDGE
}
var state : int


var current_fridge : Refrigerator

@export var move_up : String
@export var move_down : String
@export var move_left : String
@export var move_right : String

@export var dash : String
@export var action : String
@export var dance : String

func get_input() -> void:
	if !controls:
		if !Input.is_action_pressed(action):
			controls = true
			return
			
	
	match state:
		STATES.NORMAL:
			normal_movement()
		STATES.FRIDGE:
			fridge_movement()
	
	if Input.is_action_just_pressed("escape"):
		pause.pause_game()
	

func normal_movement() -> void:
	move_action = Input.get_vector(
			move_left, 
			move_right, 
			move_up, 
			move_down
			)
			
	dashed = Input.is_action_just_pressed(dash)
	dance_move = Input.is_action_just_pressed(dance)
	interact = Input.is_action_just_pressed(action)
	
func fridge_mode(fridge: Refrigerator) -> void:
	state = STATES.FRIDGE
	current_fridge = fridge
	controls = false
	
func fridge_movement() -> void:
	interact = Input.is_action_just_pressed(action)
	
	if interact:
		state = STATES.NORMAL
	
	if Input.is_action_just_pressed(move_left):
		current_fridge.back()
	if Input.is_action_just_pressed(move_right):
		current_fridge.next()
	if Input.is_action_just_pressed(move_down):
		current_fridge.close()
		state = STATES.NORMAL
		
	
	
