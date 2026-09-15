extends Control

@onready var main: Control = $Buttons/Main
@onready var play: Control = $Buttons/Main/Play
@onready var quit: Control = $Buttons/Main/Quit
@onready var options: Control = $Buttons/Main/Options

@onready var game: Control = $Buttons/Game
@onready var back: Control = $Buttons/Game/Back
@onready var solo: Button = $Buttons/Game/NewGame/Singleplayer/SingleButton
@onready var duo: Button = $Buttons/Game/NewGame/Duo/DuoButton
@onready var saves: Control = $Buttons/Game/Saves

@onready var name_ui: CanvasLayer = $Buttons/Game/EnterName

@onready var option_menu: Panel = $OptionMenu

# USED FOR SAVING WHEN PLAYER PICKED SOLO OR DUO
var is_solo: bool

func _ready() -> void:
	play.pressed.connect(play_button)
	quit.pressed.connect(quit_button)
	options.pressed.connect(option_button)
	back.pressed.connect(back_to_main)
	solo.pressed.connect(manage_save_slot.bind(true))
	duo.pressed.connect(manage_save_slot.bind(false))
	saves.load_game.connect(start_game)
	saves.register_done.connect(pick_team_name)
	name_ui.done.connect(start_game)
	
	
	main.visible = true
	game.visible = false
	name_ui.visible = false
	
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
	name_ui.visible = false

# i IS USED TO CONFIRM IF THE PLAYER IS SINGLE PLAYER OR DUO
func manage_save_slot(i: bool) -> void:
	solo.disabled = true
	duo.disabled = true
	global.single = i
	saves.enable_save_slot_selection()

# ENABLES THE NAME_UI WHERE THE PLAYER CAN INSERT THEIR TEAM NAME
func pick_team_name() -> void:
	name_ui.visible = true
	
func start_game() -> void:
	name_ui.visible = false
	get_tree().change_scene_to_file("res://Scenes/Map/house.tscn")
	
