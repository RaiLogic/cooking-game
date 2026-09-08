class_name BuildComponent extends Node2D

var is_building: bool
var selected_furniture: FurnitureData
var preview: Node2D

const GRID_SIZE: int = 16

# PLAYER ATTRIBUTES TO BE FOLLOWED BY FURNIURE
var direction: Vector2 # ASSIGNED IN PLAYER SCRIPT
var target_position: Vector2 # SNAP TO GRID

func _process(delta: float) -> void:
	if is_building and preview != null and direction != Vector2.ZERO:
		target_position = get_parent().global_position + direction * GRID_SIZE
		preview.global_position = snap_to_grid(target_position)

func select_furniture(furniture: FurnitureData) -> void:
	is_building = true
	selected_furniture = furniture
	build_mode()
	
func build_mode() -> void:
	preview = selected_furniture.scene.instantiate()
	preview.get_node("CollisionShape2D").disabled = true
	preview.modulate.a = 0.7
	preview.scale = Vector2(2.0, 2.0) # THIS IS TO NOT GET THE PLAYER'S 0.5 SCALE
	
	add_child(preview)
	
func snap_to_grid(pos) -> Vector2:
	return Vector2(
		round(pos.x / GRID_SIZE) * GRID_SIZE,
		round(pos.y / GRID_SIZE) * GRID_SIZE
	)
	
	
