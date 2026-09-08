class_name FurnitureShop extends CanvasLayer

# BUTTONS
@onready var exit: Button = $Margin/Exit/ExitButton
@onready var buy: Button = $Margin/ToolInventoryUI/Buy/BuyButton

# SHOP
@export var furnitures: Array[FurnitureData]
@onready var furniture_list: VBoxContainer = $Margin/FurnitureList/VBoxContainer
# INFORMATION OF FURNITURE
@onready var furniture_name: Label = $Margin/ToolInventoryUI/Name
@onready var furniture_price: Label = $Margin/ToolInventoryUI/Price/Price
@onready var furniture_texture: TextureRect = $Margin/ToolInventoryUI.item_ui
@onready var inventory_ui: ToolInventoryUI = $Margin/ToolInventoryUI
# THE PLAYER WHO USED THE COMPUTER
var current_player: Player
var current_furniture

# USED FOR THE FURNITURE BUTTON DESIGN
@onready var template: Control = $Margin/Template

func _ready() -> void:
	exit.pressed.connect(exit_shop)
	
	# LOAD ALL AVAILABLE FURNITURE IN THE FURNITURE ARRAY
	for furniture in furnitures:
		var item : Control = template.duplicate()
		item.visible = true
		item.get_node("Label").text = furniture.name
		furniture_list.add_child(item)
		setup_furniture(item, furniture)

func show_ui(player: Player) -> void:
	show()
	current_player = player

# SETUP BUTTON FUNCTIONALITY
func setup_furniture(item: Control, furniture: FurnitureData) -> void:
	var button : Button = item.get_node("Button")
	
	button.pressed.connect(show_furniture.bind(furniture))
	
func show_furniture(furniture: FurnitureData) -> void:
	current_furniture = furniture
	
	furniture_name.text = furniture.name
	furniture_price.text = str(furniture.price)
	
	# ATLAS WILL GET THE SPRITESHEET OF THE FURNITURE AND GET ITS SPRITE FROM THERE
	# USED TO SHOW PREVIEW OF THE TEXTURE IN THE FURNITURE PREVIEW
	var atlas : AtlasTexture = AtlasTexture.new()
	atlas.atlas = furniture.spritesheet
	atlas.region = furniture.texture_region
	furniture_texture.texture = atlas
	
	buy.pressed.connect(call_build_mode)
	
func call_build_mode() -> void:
	# IF NOTHING HAS BEEN SELECTED IN SHOP THEN PRESSING BUY
	if furniture_texture.texture == null:# or global.total_money < furniture.price:
		inventory_ui.play_alert()
		return
	
	get_tree().paused = false
	hide()
	
	current_player.build.select_furniture(current_furniture)
	current_furniture = null
	 
# WHEN PRESSED 'X' BUTTON IN SHOP UI
func exit_shop() -> void:
	visible = false
	get_tree().paused = false
	current_player = null
