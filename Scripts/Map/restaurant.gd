extends Node

@onready var p1_ui: PlayerInventoryUI = $UI/P1InventoryUI
@onready var p2_ui: PlayerInventoryUI = $UI/P2InventoryUI


@onready var player_1: Player = %Player1
@onready var player_2: Player = %Player2

func _ready() -> void:
	# show inventory to inventory ui
	player_1.inventory.item_changed.connect(p1_ui.set_inventory)
	player_2.inventory.item_changed.connect(p2_ui.set_inventory)
	
	# show alert when inventory is full
	player_1.inventory.full_inventory.connect(p1_ui.play_alert)
	player_2.inventory.full_inventory.connect(p2_ui.play_alert)
