extends Node

@onready var p1_ui: PlayerInventoryUI = $UI/P1InventoryUI
@onready var p2_ui: PlayerInventoryUI = $UI/P2InventoryUI

@onready var player_1: Player = %Player1
@onready var player_2: Player = %Player2

@onready var chairs: Array = $Interactables/Dining/Chairs.get_children()

func _ready() -> void:
	# SET MUSIC
	music_manager.play_music(music_manager.INGAME)
	
	# PLAYER MOVEMENT
	player_1.input.state = 0 # 0 MEANS NORMAL MOVEMENT
	player_2.input.state = 0
	
	
	# show inventory to inventory ui
	player_1.inventory.item_changed.connect(p1_ui.set_inventory)
	player_2.inventory.item_changed.connect(p2_ui.set_inventory)
	
	# show alert when inventory is full
	player_1.inventory.action_failed.connect(p1_ui.play_alert)
	player_2.inventory.action_failed.connect(p2_ui.play_alert)
	
	#fridge ui interaction
	player_1.interact.fridge_toggle.connect(p1_ui.set_fridge_ui)
	player_2.interact.fridge_toggle.connect(p2_ui.set_fridge_ui)
	
	player_1.interact.fridge_food_rotate.connect(p1_ui.fridge_update_ui)
	player_2.interact.fridge_food_rotate.connect(p2_ui.fridge_update_ui)

# USED FOR THE CUSTOMER FINDING ITS OWN CHAIR
func get_available_chair() -> Chair:
	for chair in chairs:
		if !chair.occupied:
			return chair
	
	return null	
