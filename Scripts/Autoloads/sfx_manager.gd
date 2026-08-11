extends Node

var current_sfx : AudioStream

func play_sfx(player: AudioStreamPlayer, sfx: AudioStream) -> void:
	current_sfx = sfx
	player.stream = sfx
	player.play()

func stop(player: AudioStreamPlayer) -> void:
	player.stop()
