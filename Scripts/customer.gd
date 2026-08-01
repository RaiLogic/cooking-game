class_name Customer extends CharacterBody2D

@export var movement : MovementComponent
@onready var order_ui: Panel = $OrderUI
@onready var interact_area: InteractedComponent = $InteractedComponent

@onready var agent : NavigationAgent2D = $NavigationAgent2D

@onready var wait: Node2D = $WaitingOrder
@onready var wait_anim: AnimationPlayer = wait.get_node("AnimationPlayer")

enum STATES {
	WALKING,
	WAITING,
	ORDERING,
	LEAVING
}
var state: STATES

# CONNECTED TO FUNCTION "remove" in Chair.gd
signal done(customer: Customer)

# FOOD ORDERING
var desired_food : Food

func _ready() -> void:
	interact_area.monitoring = false

func _physics_process(delta: float) -> void:
	movement.can_move = true
	
	if agent.is_navigation_finished():
		if state == STATES.WALKING:
			if global_position != agent.target_position:
				global_position = agent.target_position
			
			if state == STATES.WALKING:
				is_waiting(true)
				state = STATES.WAITING

			velocity = Vector2.ZERO
			interact_area.monitoring = true
			return
		elif state == STATES.LEAVING:
			queue_free()
	else:
		var next_point = agent.get_next_path_position()
		var direction = (next_point - global_position).normalized()
		movement.move(direction)

func interact(interactor: Player) -> void:
	if state == STATES.WAITING:
		# INTERACTING WHILE WAITING STATE SHOWS ORDER
		is_waiting(false)
		state = STATES.ORDERING
		show_order()
	elif state == STATES.ORDERING:
		# INTERACTING WHILE ORDERING STATE GET DESIRED FOOD OF CUSTOMER FROM PLAYER
		if interactor.inventory.item_held != desired_food:
			interactor.inventory.request_alert()
			return
		else:
			order_ui.visible = false
			interactor.inventory.clear_item()
			done.emit(self)
			done_order()
		
func set_destination(pos: Vector2) -> void:
	agent.target_desired_distance = 8.0
	agent.target_position = pos

func is_waiting(index: bool) -> void:
	if index == true:
		wait.visible = true
		wait_anim.play("show")
	elif index == false:
		wait_anim.stop()
		wait.visible = false

func show_order() -> void:
	order_ui.visible = true
	order_ui.get_node("Food").texture = desired_food.icon

func done_order() -> void:
	# CODE IN LEAVING IS IN THE CUSTOMER SPAWNER
	state = STATES.LEAVING
