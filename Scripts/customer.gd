class_name Customer extends CharacterBody2D

# COMPONENTS
@export var movement : MovementComponent
@onready var skin : SkinComponent = $Components/SkinComponent
@onready var animation: AnimationComponent = $Components/AnimationComponent
@onready var interact_area: InteractedComponent = $Components/InteractedComponent

# TEMP
@onready var sprite: Sprite2D = $Sprite2D

# NAVIGATION
@onready var agent : NavigationAgent2D = $NavigationAgent2D

# ORDERING AND WAITING
@onready var question: Node2D = $QuestionMark
@onready var question_anim: AnimationPlayer = question.get_node("AnimationPlayer")
@onready var order_ui: Panel = $OrderUI

enum STATES {
	WALKING,
	WAITING,
	ORDERING,
	LEAVING
}
var state: STATES

signal done(customer: Customer) # CONNECTED TO FUNCTION "remove" in Chair.gd
signal sitting(seated: bool) # CONNECTED TO FUNCTION


# FOOD ORDERING
var desired_food : Food
signal has_ordered(Customer)

func _ready() -> void:
	interact_area.monitoring = false
	movement.can_move = true
	animation.sprite = skin.get_random_skin()

func _physics_process(delta: float) -> void:
	
	navigation_check()
	
	if state == STATES.WALKING:
		animation.update_anim(velocity)

func interact(interactor: Player) -> void:
	if state == STATES.WAITING:
		# INTERACTING WHILE WAITING STATE SHOWS ORDER
		is_sitting(false)
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
			done.emit(self) # to customer_spawner
			done_order()
			
func set_destination(pos: Vector2) -> void:
	agent.target_desired_distance = 8.0
	agent.target_position = pos
	
func navigation_check() -> void:
	if !agent.is_navigation_finished():
		var next_point = agent.get_next_path_position()
		var direction = (next_point - global_position).normalized()
		movement.move(direction)
		return
	
	if global_position != agent.target_position:
		# FOR CHAIR POSITION AND SPRITES, ALIGN CUSTOMER TO CHAIR
		global_position = agent.target_position
	
	if state == STATES.WALKING:
		sitting.emit(true)
		is_sitting(true)
		state = STATES.WAITING

		velocity = Vector2.ZERO
		interact_area.monitoring = true
		return

	if state == STATES.LEAVING:
		queue_free()

func is_sitting(index: bool) -> void:
	if index == true:
		question.visible = true
		question_anim.play("show")
	elif index == false:
		question_anim.stop()
		question.visible = false

func show_order() -> void:
	order_ui.visible = true
	order_ui.get_node("Food").texture = desired_food.icon
	has_ordered.emit(self)

func done_order() -> void:
	# CODE IN LEAVING IS IN THE CUSTOMER SPAWNER
	state = STATES.LEAVING
	global.add_money(120)
