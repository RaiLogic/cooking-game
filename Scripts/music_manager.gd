extends Node

@onready var player = preload("res://Scenes/music_manager.tscn")

var current_music : AudioStream

func play_music(music: AudioStream) -> void:
	if current_music == music:
		print("Already Playing!")
		return
	
	print(player)
