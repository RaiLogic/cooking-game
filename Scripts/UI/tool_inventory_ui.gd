extends Panel

@onready var item_ui: TextureRect = $TextureRect

func _ready() -> void:
	visible = false

func set_ui(item: Food) -> void:
	if item != null:
		item_ui.texture = item.icon
		visible = true
	
func clear_ui() -> void:
	visible = false
	item_ui.texture = null
