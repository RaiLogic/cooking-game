extends Control

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

const ALARM_CLOCK_SOUND = preload("uid://cmtbn11jcjg41")

signal done

func play() -> void:
	music_manager.stop_music()
	
	visible = true
	animation.play("show")
	sfx_manager.play_sfx(audio, ALARM_CLOCK_SOUND, 0.5)
	await animation.animation_finished
	
	
	animation.play("fade_out")
	await animation.animation_finished
	done.emit()
	
