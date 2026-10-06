class_name FurnitureData extends Resource

@export var name: String
@export var scene: PackedScene
@export var price: int
@export var size: Vector2i
@export var spritesheet: Texture2D
@export var texture_region: Rect2

# USED TO PUT THE FURNITURE IN THE GRID | DECLARED IN THE BUILD_COMPONENT
var grid_anchor: Vector2i
