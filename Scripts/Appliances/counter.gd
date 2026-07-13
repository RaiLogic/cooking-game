class_name Counter extends StaticBody2D

@onready var top_sprite: Node2D = $TopSprite
@onready var bot_sprite: Node2D = $BottomSprite
@onready var plate_ui: TextureRect = $TextureRect2
@onready var food_ui: TextureRect = $Food

@export var part : String

func _ready() -> void:
	check_placement()
	
func check_placement() -> void:
	bot_sprite.get_node(part).visible = true
	top_sprite.get_node(part).visible = true

func interact(interactor: Player) -> void:
	if interactor.inventory.item_held == null:
		print("no item in inventory")
		return
		
	print("item here/")
