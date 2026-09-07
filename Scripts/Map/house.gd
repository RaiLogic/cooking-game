extends Node

# LOCATION
const LOCATION = global.LOCATIONS.HOUSE

@onready var money_ui: Control = $UI/MoneyUI

# SHOP
@onready var shop: CanvasLayer = $FurnitureShop
@onready var computer: StaticBody2D = $World/Furnitures/Interactable/Computer

func _ready() -> void:
	global.set_location(LOCATION)
	money_ui.change_value(global.total_money)
	computer.opened.connect(show_shop)

# WILL BE SHOWN IN THE COMPUTER SCENE
# USED TO SHOW SHOP UI USING COMPUTER
func show_shop() -> void:
	shop.show()

func _on_leave_house_entered(body: Player) -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/restaurant.tscn")
