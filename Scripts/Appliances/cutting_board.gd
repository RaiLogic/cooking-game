class_name CuttingBoard extends StaticBody2D

@onready var progress_bar: Panel = $Progress
@onready var tool_inventory: Panel = $ToolInventoryUI

@export var slice_time : float

var item : Food
var player : Player

enum STATES {
	EMPTY,
	SLICING,
	FULL
}

var current_state : int = STATES.EMPTY

func _ready() -> void:
	progress_bar.finish.connect(finished)

func interact(interactor: Player) -> void:
	player = interactor
	match current_state:
		STATES.EMPTY:
			if check_item():
				current_state = STATES.SLICING
				player.inventory.clear_item()
				set_move(false)
				slice()
		STATES.SLICING:
			tool_inventory.play_alert()
		STATES.FULL:
			if player.inventory.add_item(item.sliced_version):
				restart()
	

func check_item() -> bool:
	if player.inventory.item_held == null: 
		player.inventory.full_inventory.emit()
		return false
	if player.inventory.item_held.can_slice == false: 
		player.inventory.full_inventory.emit()
		return false
	# checks if the player is holding the item
	# checks if the player's item can be cooked
	
	item = player.inventory.item_held
	return true
	
func set_move(toggle: bool) -> void:
	if toggle:
		player.input.controls = true
	else:
		player.input.controls = false
		
func slice() -> void:
	tool_inventory.visible = true
	tool_inventory.set_ui(item)
	progress_bar.start(item.slice_time)
	
func finished() -> void:
	set_move(true)
	tool_inventory.set_ui(item.sliced_version)
	current_state = STATES.FULL
	
	
func restart() -> void:
	tool_inventory.clear_ui()
	progress_bar.restart()
	
