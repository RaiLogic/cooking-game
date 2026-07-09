class_name Refrigerator extends StaticBody2D

@export var food_group : Array[Food]

var food_available : Array[Food]
var food : Food
var last_picked_food : Food = null

func get_stored_item() -> void:
	avoid_last_obtained()
	
	food = food_available.pick_random()
	last_picked_food = food

func avoid_last_obtained() -> void:
	food_available = food_group.duplicate()
	if last_picked_food != null:
		food_available.erase(last_picked_food)

func interact(interactor: Player) -> void:
	get_stored_item()
	
	interactor.inventory.set_item(food)
