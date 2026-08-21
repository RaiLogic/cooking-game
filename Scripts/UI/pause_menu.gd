extends CanvasLayer

@onready var resume: Control = $Menu/Resume
@onready var options: Control = $Menu/Options
@onready var back: Control = $Menu/Back

@onready var menu: Panel = $Menu
@onready var option_menu: Panel = $OptionMenu

var is_paused : bool = false
	
func _ready() -> void:
	options.pressed.connect(show_option)
	back.pressed.connect(back_to_main)
	resume.pressed.connect(resume_game)
	option_menu.back.pressed.connect(back_to_menu)
	
	visible = false

# PAUSE GAME AND SHOW MENU
func pause_game() -> void:
	is_paused = true
	visible = true
	get_tree().paused = true
	
func resume_game() -> void:
	is_paused = false
	get_tree().paused = false
	visible = false
	menu.visible = true

func back_to_main() -> void:
	get_tree().paused = false
	visible = false
	get_tree().change_scene_to_file("res://Scenes/UI/main.tscn")
	
func back_to_menu() -> void:
	menu.visible = true
	visible = true
	
func show_option() -> void:
	option_menu.visible = true
	menu.visible = false
	
