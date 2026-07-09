class_name Stove extends StaticBody2D


@onready var progress_bar: Panel = $Progress
@onready var tool_inventory: Panel = $ToolInventoryUI

@export var cooking_time : float

var item : Food
var running : bool
var occupied : bool


func _ready() -> void:
	progress_bar.done.connect(update_item)

func interact(interactor: Player) -> void:
	if occupied and !running:
		done()
		interactor.inventory.set_item(item.cooked_version)
	
	elif !running and !occupied:
		running = true
		
		if interactor.inventory.item_held == null:
			return
		
		item = interactor.inventory.item_held
		
		if item.can_cook:
			interactor.inventory.clear_item()
			cook()
			
		
func cook() -> void:
	occupied = true
	tool_inventory.visible = true
	tool_inventory.set_ui(item)
	progress_bar.start(item.cook_time)
	
func update_item() -> void:
	tool_inventory.set_ui(item.cooked_version)
	running = false
	
func done() -> void:
	tool_inventory.clear_ui()
	progress_bar.restart()
