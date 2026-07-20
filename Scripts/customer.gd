class_name Customer extends CharacterBody2D

@export var movement : MovementComponent
@onready var order_ui: Panel = $OrderUI

@onready var agent : NavigationAgent2D = $NavigationAgent2D

signal arrived
# FOOD ORDERING
var desired_food : Food

func _physics_process(delta: float) -> void:
	movement.can_move = true
	
	if agent.is_navigation_finished():
		arrived.emit()
		velocity = Vector2.ZERO
		return
	else:
		var next_point = agent.get_next_path_position()
		var direction = (next_point - global_position).normalized()
		movement.move(direction)
	
		
func set_destination(pos: Vector2) -> void:
	agent.target_position = pos

func show_order() -> void:
	order_ui.visible = true
	order_ui.get_node("Food").texture = desired_food.icon
