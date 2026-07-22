extends Node

enum LOCATIONS {
	MAIN_MENU,
	RESTAURANT,
	HOUSE
}

var current_location : int = LOCATIONS.MAIN_MENU



func _ready() -> void:
	music_manager.play_music(music_manager.MENU)
	
func set_location(location):
	current_location = location
	
	match current_location:
		LOCATIONS.MAIN_MENU:
			music_manager.play_music(music_manager.MENU)
		LOCATIONS.RESTAURANT:
			music_manager.play_music(music_manager.INGAME)
