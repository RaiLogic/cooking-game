extends Control

@onready var play: Control = $Buttons/Play
@onready var quit: Control = $Buttons/Quit
@onready var options: Control = $Buttons/Options

@onready var option_menu: Panel = $OptionMenu

func _ready() -> void:
	play.pressed.connect(play_button)
	quit.pressed.connect(quit_button)
	options.pressed.connect(option_button)
	
	music_manager.play_music(music_manager.MENU)
	
func play_button() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/restaurant.tscn")
	music_manager.play_music(music_manager.INGAME)
	
func quit_button() -> void:
	get_tree().quit()
	
func option_button() -> void:
	if option_menu.visible:
		option_menu.visible = false
	else:
		option_menu.visible = true
	
