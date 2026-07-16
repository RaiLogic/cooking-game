class_name Counter extends StaticBody2D

@onready var top_sprite: Node2D = $TopSprite
@onready var bot_sprite: Node2D = $BottomSprite
@onready var plate_ui: TextureRect = $TextureRect2
@onready var food_ui: TextureRect = $Food

@export var part : String

var player : Player
var item : Resource

func _ready() -> void:
	check_orientation()
	
func check_orientation() -> void:
	bot_sprite.get_node(part).visible = true
	top_sprite.get_node(part).visible = true

func interact(interactor: Player) -> void:
	player = interactor
	if has_item():
		if player.inventory.has_item():
			item = player.inventory.item_held
			food_ui.texture = item.icon
			player.inventory.clear_item()
	else:
		if can_give_item():
			player.inventory.add_item(item)
			food_ui.texture = null
			item = null
			plate_ui.visible = true

func has_item() -> bool:
	if item != null:
		return false
	
	return true
	
func can_give_item() -> bool:
	if player.inventory.has_item():
		player.inventory.request_alert()
		return false
	else:
		return true
	
