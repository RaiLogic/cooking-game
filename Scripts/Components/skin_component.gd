class_name SkinComponent extends Node

# THIS IS USED FOR CUSTOMERS BUT MIGHT USE FOR PLAYERS IN THE FUTURE

@onready var skins : Array = get_children()
@onready var selected_skin: AnimatedSprite2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if skins.is_empty():
		print("No skins on ", name)
		return
	
func get_random_skin() -> AnimatedSprite2D:
	selected_skin = skins.pick_random()
	selected_skin.visible = true
	return selected_skin

# FOR FUTURE PLAYER SKIN SELECTING PURPOSES
func get_skin() -> void:
	pass
