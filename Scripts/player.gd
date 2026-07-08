class_name Player extends CharacterBody2D

@export var input: InputComponent
@export var movement: MovementComponent
@export var dash: DashComponent
@export var animate: AnimationComponent
@export var interact: InteractorComponent

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# INPUTS
	input.get_input()
	
	# MOVEMENT
	movement.direction = input.move_action
	movement.do(delta)
	movement.speed = movement.base_speed
	
	# DASH
	if input.dashed and movement.direction != Vector2(0,0):
		dash.dash_action()
		
	if dash.dash_moving:
		movement.speed *= dash.speed_multiplier
	
	# ANIMATION
	animate.action()
	animate.direction = movement.direction
	
	# INTERACTION
	if input.interact:
		interact.action(self)
		
	# INVENTORY
