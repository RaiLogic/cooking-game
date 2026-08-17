extends Node

# LOCATION
const LOCATION = global.LOCATIONS.HOUSE

func _ready() -> void:
	global.set_location(LOCATION)

func _on_leave_house_entered(body: Player) -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/restaurant.tscn")
