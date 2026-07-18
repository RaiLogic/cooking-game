extends Node

var current_music : AudioStream

func _ready() -> void:
	print("Music Manger Ready")

func play_music(music: AudioStream) -> void:
	var player: AudioStreamPlayer = get_node("AudioStreamPlayer")
	
	if current_music == music:
		print("Already Playing!")
		return
	
	music.loop = true
	current_music = music
	player.stream = music
	player.play()
