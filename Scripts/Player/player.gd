class_name Player extends CharacterBody2D

@export var input: InputComponent
@export var movement: MovementComponent
@export var dash: DashComponent
@export var animate: AnimationComponent
@export var interact: InteractorComponent
@export var inventory: InventoryComponent

func _physics_process(delta: float) -> void:
	# JUST FOR TESTING STUFF, THIS IS TO AVOID BOTH PROCESS RUNNING AND KEEP IT
	# ONE PLAYER
	#if name == "Player2":
		#return
	
	# INPUTS
	input.get_input()
	
	# MOVEMENT
	movement.move(input.move_action)
	movement.speed = movement.base_speed
	if interact.interacting: set_move(false)
	else: set_move(true)
	
	# DASH
	if input.dashed and movement.moving:
		dash.dash_action()
		
	if dash.dash_moving:
		movement.speed *= dash.speed_multiplier
	
	# ANIMATION
	animate.update_anim(velocity)
	
	if input.dance_move:
		animate.dance()

	# INTERACTION
	if input.interact:
		interact.action(self)
	if interact.interacting:
		set_move(false)
	else:
		set_move(true)



func set_move(move: bool) -> void:
	if move:
		movement.can_move = true
	else:
		movement.can_move = false
		velocity = Vector2.ZERO
