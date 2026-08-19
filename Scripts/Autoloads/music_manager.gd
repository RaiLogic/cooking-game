extends Node

var current_music : AudioStream
@onready var player: AudioStreamPlayer = get_node("AudioStreamPlayer")

#MUSICS
const MENU = preload("res://Assets/Music/Mainmenu Music.mp3")
const INGAME = preload("res://Assets/Music/Ingame Music.mp3")


func play_music(music: AudioStream) -> void:
	if current_music == music:
		return
	
	music.loop = true
	current_music = music
	player.stream = music
	player.play()
	
func stop_music() -> void:
	player.stop()
