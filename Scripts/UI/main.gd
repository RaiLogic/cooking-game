extends Control

@onready var main: Control = $Buttons/Main
@onready var play: Control = $Buttons/Main/Play
@onready var quit: Control = $Buttons/Main/Quit
@onready var options: Control = $Buttons/Main/Options

@onready var game: Control = $Buttons/Game
@onready var back: Control = $Buttons/Game/Back
@onready var single: Button = $Buttons/Game/NewGame/Singleplayer/SingleButton
@onready var duo: Button = $Buttons/Game/NewGame/Duo/DuoButton

@onready var option_menu: Panel = $OptionMenu

func _ready() -> void:
	play.pressed.connect(play_button)
	quit.pressed.connect(quit_button)
	options.pressed.connect(option_button)
	back.pressed.connect(back_to_main)
	single.pressed.connect(start_game.bind(1))
	duo.pressed.connect(start_game.bind(0))
	
	main.visible = true
	game.visible = false
	
	music_manager.play_music(music_manager.MENU)
	
func play_button() -> void:
	main.visible = false
	game.visible = true
	
func quit_button() -> void:
	get_tree().quit()
	
func option_button() -> void:
	if option_menu.visible:
		option_menu.visible = false
	else:
		option_menu.visible = true
		
func back_to_main() -> void:
	game.visible = false
	main.visible = true
	
func start_game(is_solo: bool) -> void:
	global.single = is_solo
	get_tree().change_scene_to_file("res://Scenes/Map/house.tscn")
	
