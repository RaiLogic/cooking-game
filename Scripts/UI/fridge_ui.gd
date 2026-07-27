class_name FridgeUI extends Panel

@onready var prev_food: TextureRect = $PrevFood
@onready var current_food: TextureRect = $CurrentFood
@onready var next_food: TextureRect = $NextFood

func update_ui(previous, current, next) -> void:
	current_food.texture = current.icon
	prev_food.texture = previous.icon
	next_food.texture = next.icon
