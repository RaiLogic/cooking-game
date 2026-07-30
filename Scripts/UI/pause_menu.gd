extends Panel

@onready var options: Control = $Options
@onready var back: Control = $Back
@onready var resume: Control = $Resume


func _ready() -> void:
	back.pressed.connect(back_to_menu)
	

func _process(delta: float) -> void:
	pass
	
func back_to_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/main.tscn")
