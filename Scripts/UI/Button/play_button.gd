extends Control

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/restaurant.tscn")
	global.set_location(global.LOCATIONS.RESTAURANT)
