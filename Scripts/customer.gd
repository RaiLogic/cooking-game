class_name Customer extends CharacterBody2D

# COMPONENTS
@export var movement : MovementComponent
@onready var skin : SkinComponent = $Components/SkinComponent
@onready var animation: AnimationComponent = $Components/AnimationComponent
@onready var interact_area: InteractedComponent = $Components/InteractedComponent

# NAVIGATION
@onready var agent : NavigationAgent2D = $NavigationAgent2D

# ORDERING AND WAITING
@onready var question: Node2D = $QuestionMark
@onready var order_ui: Panel = $OrderUI
@onready var progress: Panel = $Progress

# FOOD ORDERING
var desired_food : Food
signal has_ordered(Customer) # CONNECTED TO FUNCTION "add_order" in orders_ui.gd
signal eating(Customer) # CONNECTED TO FUNCTION "remove_order" in orders_ui.gd

#region STATES
signal done(customer: Customer) # CONNECTED TO FUNCTION "remove" in Chair.gd
signal state_changed(seated: bool) # CONNECTED TO FUNCTION "update_sprite" in Chair.gd

enum STATES {
	WALKING,
	WAITING,
	ORDERING,
	EATING,
	LEAVING
}
var state: STATES

enum EMOTION_STATES {
	HAPPY,
	NEUTRAL,
	SAD,
	ANGRY
}
var emotion_state : EMOTION_STATES # NOT FINISHED YET
#endregion

func _ready() -> void:
	interact_area.monitoring = false
	movement.can_move = true
	animation.sprite = skin.get_random_skin()
	progress.finish.connect(done_order)
	state = STATES.WALKING
	emotion_state = EMOTION_STATES.HAPPY

func _physics_process(_delta: float) -> void:
	navigation_check()
	
	if state == STATES.WALKING or state == STATES.LEAVING:
		animation.update_anim(velocity)

func interact(interactor: Player) -> void:
	if state == STATES.WAITING:
		# INTERACTING WHILE WAITING STATE SHOWS ORDER
		question.hide_mark()
		state = STATES.ORDERING
		show_order()
		state_changed.emit()
	elif state == STATES.ORDERING:
		# INTERACTING WHILE ORDERING STATE GET DESIRED FOOD OF CUSTOMER FROM PLAYER
		if interactor.inventory.item_held != desired_food: 
			# THIS IS IF THE PLAYER IS 'NOT GIVING' WHAT THE CUSTOMER WANTS
			interactor.inventory.request_alert()
			return
		else:
			# THIS IS IF THE ORDER IS ACCEPTED AND WHAT THE CUSTOMER WANTS
			order_ui.visible = false
			interactor.inventory.clear_item()
			state = STATES.EATING
			state_changed.emit()
			eating.emit(self)
			# VALUE IS HARD SET AND MIGHT CHANGE SOON
			progress.start(10.0)
			# THIS IS TO NOT SHOW THE PROGRESS BAR AND MAKE IT LOOK LIKE THE CUSTOMER IS
			# JUST EATING
			progress.visible = false 

#region NAVIGATION
# THIS STARTS THE CUSTOMER'S WALKING PROCESS TOWARDS THE 'POS'
func set_destination(pos: Vector2) -> void:
	agent.target_desired_distance = 8.0
	agent.target_position = pos
	
func navigation_check() -> void:
	# WHEN NAVIGATING/WALKING TOWARDS THE CHAIR
	if !agent.is_navigation_finished():
		var next_point = agent.get_next_path_position()
		var direction = (next_point - global_position).normalized()
		movement.move(direction)
		return
	
	# WHEN CUSTOMER IS FINISHED WALKING
	if global_position != agent.target_position:
		# FOR CHAIR POSITION AND SPRITES, ALIGN CUSTOMER TO CHAIR
		global_position = agent.target_position
	
	# IF THEY GOT IN THEIR CHAIR
	if state == STATES.WALKING:
		state_changed.emit()
		question.show_mark()
		state = STATES.WAITING
		state_changed.emit()

		velocity = Vector2.ZERO
		interact_area.monitoring = true
		return
	
	# IF THEY ARE NOW OUTSIDE
	if state == STATES.LEAVING:
		queue_free()
	###
#endregion

# SHOW ORDER ABOVE THE CUSTOMER
func show_order() -> void:
	order_ui.visible = true
	order_ui.get_node("Food").texture = desired_food.icon
	has_ordered.emit(self)

# CODE IN LEAVING IS IN THE CUSTOMER SPAWNER
func done_order() -> void:
	progress.restart()
	state = STATES.LEAVING
	done.emit(self)
	state_changed.emit()
	
	global.add_money(120)
