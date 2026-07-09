extends Node

@onready var inventory_ui: Control = $UI/InventoryUI
@onready var player_1: Player = %Player1
@onready var player_2: Player = %Player2

func _ready() -> void:
	player_1.inventory.item_changed.connect(inventory_ui.set_inventory_1)
