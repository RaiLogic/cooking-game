class_name FurnitureShop extends CanvasLayer

# BUTTONS
@onready var exit: Button = $Margin/Exit/ExitButton
@onready var buy: Button = $Margin/FurniturePreview/Buy/BuyButton

# SHOP
@export var furnitures: Array[FurnitureData]
@onready var furniture_list: VBoxContainer = $Margin/FurnitureList/VBoxContainer
# INFORMATION OF FURNITURE
@onready var furniture_name: Label = $Margin/FurniturePreview/Name
@onready var furniture_price: Label = $Margin/FurniturePreview/Price/Price
@onready var furniture_texture: TextureRect = $Margin/FurniturePreview/TextureRect
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

# SETUP BUTTON FUNCTIONALITY
func setup_furniture(item: Control, furniture: FurnitureData) -> void:
	var button : Button = item.get_node("Button")
	
	button.pressed.connect(show_furniture.bind(furniture))
	
func show_furniture(furniture: FurnitureData) -> void:
	furniture_name.text = furniture.name
	furniture_price.text = str(furniture.price)
	
	# ATLAS WILL GET THE SPRITESHEET OF THE FURNITURE AND GET ITS SPRITE FROM THERE
	# USED TO SHOW PREVIEW OF THE TEXTURE IN THE FURNITURE PREVIEW
	var atlas : AtlasTexture = AtlasTexture.new()
	atlas.atlas = furniture.spritesheet
	atlas.region = furniture.texture_region
	
	furniture_texture.texture = atlas
	 
# WHEN PRESSED 'X' BUTTON IN SHOP UI
func exit_shop() -> void:
	visible = false
