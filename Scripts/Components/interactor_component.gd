class_name InteractorComponent extends Node

var type : String
var current_interacted: InteractedComponent = null
var interacting : bool = false

signal fridge_food_rotate(Food)
signal fridge_toggle

func _ready() -> void:
	fridge_toggle.connect(set_interacts)

func set_interacted(interacted: InteractedComponent) -> void:
	current_interacted = interacted

func clear_interacted(interacted: InteractedComponent) -> void:
	if current_interacted == interacted:
		current_interacted = null

func action(interactor: Player) -> void:
	if current_interacted != null:
		current_interacted.interact(interactor)
		
func set_interacts() -> void:
	# PREVENTS PLAYER MOVING SO THE PLAYER CAN FOCUS ON 
	# CHOOSING FOOD
	if interacting or !interacting: 
		interacting = !interacting
