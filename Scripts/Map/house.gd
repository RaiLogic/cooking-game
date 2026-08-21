extends Node

# LOCATION
const LOCATION = global.LOCATIONS.HOUSE

@onready var money_ui: Control = $UI/MoneyUI

func _ready() -> void:
	global.set_location(LOCATION)
	money_ui.change_value(global.total_money)

func _on_leave_house_entered(body: Player) -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/restaurant.tscn")
