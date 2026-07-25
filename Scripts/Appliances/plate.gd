class_name Plate extends StaticBody2D


@onready var progress_bar: Panel = $Progress
@onready var plating_ui: PlatingUI = $PlatingUI

var player: Player

var item : Food = null
var items: Array[Food]
const MAX_ITEMS : int = 3

var dish_craftable : bool = false

var current_recipe: Recipe
@export var recipes: Array[Recipe]

func _ready() -> void:
	progress_bar.finish.connect(done)

func interact(interactor: Player) -> void:
	player = interactor
	item = player.inventory.item_held
	if player.inventory.has_item() and dish_craftable == false:
		if player.inventory.item_held is Food:
			if set_slot():
				check_recipe()
				player.inventory.clear_item()
	else:
		get_item_slot()
		
func set_slot() -> bool:
	if items.size() >= MAX_ITEMS:
		plating_ui.request_alert()
		return false
	items.append(item)
	plating_ui.set_item(items.size(), item)
	
	return true

func get_item_slot() -> void:
	if items.is_empty():
		player.inventory.request_alert()
		return
	elif dish_craftable:
		progress_bar.start(current_recipe.plating_time)
		player.interact.interacting = true
	else:
		plating_ui.clear_item(items.size())
		item = items.pop_back()
		player.inventory.add_item(item)
	
func check_recipe() -> void:
	for r in recipes:
		if matches_recipe(r):
			dish_found(r)

func matches_recipe(recipe: Recipe) -> bool:
	if items.size() != recipe.ingredients.size():
		return false 
		# Checks if Recipe is not the same amount in ingredients
	
	for ingredient in recipe.ingredients:
		if !items.has(ingredient):
			return false
		# Checks if the ingredients doenst match with the recipe
	
	return true

func dish_found(recipe: Recipe) -> void:
	dish_craftable = true
	current_recipe = recipe
	item = recipe.result
	plating_ui.show_result(recipe.result)

func done() -> void:
	print(current_recipe.result)
	player.inventory.add_item(current_recipe.result)
	restart()

func restart() -> void:
	progress_bar.restart()
	plating_ui.clear_all()
	dish_craftable = false
	items.clear()
	player.interact.interacting = false
