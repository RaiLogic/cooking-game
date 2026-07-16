extends Node

enum LOCATIONS {
	MAIN_MENU,
	RESTAURANT,
	HOUSE
}

var current_location : int = LOCATIONS.MAIN_MENU

#MUSICS
const MENU = preload("res://Assets/Music/Mainmenu Music.mp3")
const INGAME = preload("res://Assets/Music/Ingame Music.mp3")

func _ready() -> void:
	music_manager.play_music(MENU)
	
func set_location(location):
	current_location = location
	
	match current_location:
		LOCATIONS.MAIN_MENU:
			music_manager.play_music(MENU)
		LOCATIONS.RESTAURANT:
			music_manager.play_music(INGAME)
