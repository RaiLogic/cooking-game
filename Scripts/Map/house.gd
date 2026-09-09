extends Node

# LOCATION
const LOCATION = global.LOCATIONS.HOUSE

@onready var money_ui: Control = $UI/MoneyUI

# SHOP
@onready var shop: FurnitureShop = $FurnitureShop
@onready var computer: Computer = $World/Furnitures/Interactable/Computer

# PLAYERS
@onready var player_1: Player = %Player1
@onready var player_2: Player = %Player2

# FURNITURE POSITION IN SCENE
@onready var player_furnitures: Node2D = $World/Furnitures/PlayerPlaced

func _ready() -> void:
	global.set_location(LOCATION)
	money_ui.change_value(global.total_money)
	computer.shop_ui = $FurnitureShop

func _on_leave_house_entered(body: Player) -> void:
	get_tree().paused = true
	await fade.fade_out(3.0)
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Map/restaurant.tscn")
	fade.fade_in(3.0)
	
