class_name Customer extends CharacterBody2D

@export var movement : MovementComponent
@onready var order_ui: Panel = $OrderUI
@onready var interact_area: InteractedComponent = $InteractedComponent

@onready var agent : NavigationAgent2D = $NavigationAgent2D

enum STATES {
	WALKING,
	ORDERING,
	LEAVING
}
var state: STATES

signal done(customer: Customer)
# FOOD ORDERING
var desired_food : Food

func _ready() -> void:
	interact_area.monitoring = false

func _physics_process(delta: float) -> void:
	if state == STATES.LEAVING: 
		return
	
	movement.can_move = true
	
	if agent.is_navigation_finished():
		state = STATES.ORDERING
		show_order()
		velocity = Vector2.ZERO
		return
	else:
		var next_point = agent.get_next_path_position()
		var direction = (next_point - global_position).normalized()
		movement.move(direction)

func interact(interactor: Player) -> void:
	if interactor.inventory.item_held != desired_food:
		print("Wrong Food!")
		return
	
	print("Thank you!")
	interactor.inventory.clear_item()
	done.emit(self)
		
func set_destination(pos: Vector2) -> void:
	agent.target_position = pos

func show_order() -> void:
	interact_area.monitoring = true
	order_ui.visible = true
	order_ui.get_node("Food").texture = desired_food.icon
	


	
