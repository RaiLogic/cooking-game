extends Panel

@onready var options: Control = $Options
@onready var back: Control = $Back
@onready var resume: Control = $Resume

@onready var option_menu: Panel = $OptionMenu

var camera : Camera2D

var paused : bool = false
	
func _ready() -> void:
	options.pressed.connect(show_option)
	back.pressed.connect(back_to)
	resume.pressed.connect(resume_game)
	
	visible = false
	
func pause_game() -> void:
	visible = true
	get_tree().paused = true
	camera.zoom = Vector2(1,1)
	
func resume_game() -> void:
	get_tree().paused = false
	visible = false

func back_to() -> void:
	get_tree().paused = false
	visible = false
	get_tree().change_scene_to_file("res://Scenes/UI/main.tscn")
	
func show_option() -> void:
	option_menu.visible = true
	
