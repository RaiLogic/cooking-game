extends Node

@onready var p1_ui: PlayerInventoryUI = $UI/P1InventoryUI
@onready var p2_ui: PlayerInventoryUI = $UI/P2InventoryUI

@onready var player_1: Player = %Player1
@onready var player_2: Player = %Player2

@onready var chairs: Array = $Interactables/Dining/Chairs.get_children()

func _ready() -> void:
	player_1.movement.can_move = true
	player_2.movement.can_move = true
	# show inventory to inventory ui
	player_1.inventory.item_changed.connect(p1_ui.set_inventory)
	player_2.inventory.item_changed.connect(p2_ui.set_inventory)
	
	# show alert when inventory is full
	player_1.inventory.action_failed.connect(p1_ui.play_alert)
	player_2.inventory.action_failed.connect(p2_ui.play_alert)
	
	#fridge ui interaction
	player_1.interact.fridge_open.connect(p1_ui.fridge_ui)
	player_2.interact.fridge_open.connect(p2_ui.fridge_ui)
	
func get_available_chair() -> Chair:
	for chair in chairs:
		if !chair.occupied:
			print(chair, ", not occupied")
			return chair
	
	return null	
