extends Node

func play_sfx(player: AudioStreamPlayer, sfx: AudioStream, start_time: float) -> void:
	player.stream = sfx
	player.play(start_time)

func fade_in(player: AudioStreamPlayer, duration: float) -> void:
	player.volume_db = -80.0
	
	var tween = create_tween()
	tween.tween_property(player, "volume_db", 0.0, duration)

func fade_out(player: AudioStreamPlayer, duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(player, "volume_db", -80.0, duration)
	await tween.finished

func stop(player: AudioStreamPlayer) -> void:
	player.stop()
	
