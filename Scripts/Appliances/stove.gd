class_name Stove extends StaticBody2D


@onready var progress_bar: Panel = $Progress
@onready var tool_inventory: Panel = $ToolInventoryUI

@export var cooking_time : float

var item : Food

enum STATES {
	EMPTY,
	COOKING,
	FULL
}

var current_state : int = STATES.EMPTY

func _ready() -> void:
	progress_bar.finish.connect(finished)

func interact(interactor: Player) -> void:
	match current_state:
		STATES.EMPTY:
			if check_item(interactor):
				current_state = STATES.COOKING
				interactor.inventory.clear_item()
				cook()
		STATES.COOKING:
			tool_inventory.alert()
		STATES.FULL:
			item = item.cooked_version
			if interactor.inventory.add_item(item):
				restart()
	

func check_item(interactor: Player) -> bool:
	if interactor.inventory.item_held == null: 
		return false
	if interactor.inventory.item_held.can_cook == false: 
		return false
	# checks if the player is holding the item
	# checks if the player's item can be cooked
	
	item = interactor.inventory.item_held
	return true
		
func cook() -> void:
	tool_inventory.visible = true
	tool_inventory.set_ui(item)
	progress_bar.start(item.cook_time)
	
func finished() -> void:
	tool_inventory.set_ui(item.cooked_version)
	current_state = STATES.FULL
	
	
func restart() -> void:
	tool_inventory.clear_ui()
	progress_bar.restart()
	
