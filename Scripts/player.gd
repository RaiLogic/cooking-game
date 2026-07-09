class_name Player extends CharacterBody2D

@export var input: InputComponent
@export var movement: MovementComponent
@export var dash: DashComponent
@export var animate: AnimationComponent
@export var interact: InteractorComponent
@export var inventory: InventoryComponent

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# INPUTS
	input.get_input()
	
	# MOVEMENT
	movement.direction = input.move_action
	movement.move()
	movement.speed = movement.base_speed
	movement.can_move = input.controls
	
	# DASH
	if input.dashed and movement.direction != Vector2(0,0):
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
		
	# INVENTORY
	
