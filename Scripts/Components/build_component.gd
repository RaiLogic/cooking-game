class_name BuildComponent extends Node2D

# PLAYER IS THE PARENT
@onready var player : Player = get_parent()

@onready var build_manager: Node2D = %BuildManager

var is_building: bool = false # INDICATOR IF A PLAYER IS IN BUILD MODE
var selected_furniture: FurnitureData # SELECTED FURNITURE OF THE PLAYER
var can_place: bool # IF THE FURNITURE IS PLACEABLE

var preview: Node2D
# USED IN ALIGNING THE PREVIEW TO GRID ALIGNED WITH THE BUILDABLE FLOOR
var preview_cell: Vector2i

const GRID_SIZE: int = 16

# BUILD MODE SIGNALS
signal build_started # USED FOR THE BUILD MANAGER

# PLAYER ATTRIBUTES TO BE FOLLOWED BY FURNIURE
var direction: Vector2 # ASSIGNED IN PLAYER SCRIPT
var target_position: Vector2
@onready var furniture_container = (
	get_tree().current_scene.get_node("World/Players/PlayerFurnitures")
	)

# NO USE YET
signal furniture_placed(furniture: FurnitureData)

func _process(delta: float) -> void:
	if is_building and preview != null:
		if direction != Vector2.ZERO:
			target_position = player.global_position + direction * GRID_SIZE
			preview.global_position = snap_to_grid(target_position)
			
		if player.input.interact:
			place_furniture()
			
		check_availability()


func select_furniture(furniture: FurnitureData) -> void:
	is_building = true
	selected_furniture = furniture
	build_mode()
	
func build_mode() -> void:
	preview = selected_furniture.scene.instantiate()
	preview.get_node("CollisionShape2D").disabled = true
	preview.modulate.a = 0.6
	preview.scale = Vector2(2.0, 2.0) # THIS IS TO NOT GET THE PLAYER'S 0.5 SCALE
	
	add_child(preview)
	build_started.emit()
	
# SNAPS FURNITURE TO GRID WHILE ALIGNED WITH BUILDABLE FLOOR
func snap_to_grid(pos) -> Vector2:
	var local_pos = build_manager.floor.to_local(pos)
	preview_cell = build_manager.floor.local_to_map(local_pos)

	return build_manager.floor.to_global(
		build_manager.floor.map_to_local(preview_cell)
	)
	
	
# USED TO CHECK AVAILABLE SPACE BASED ON FUNCTIONS IN BUILD MANAGER
func check_availability() -> void:
	if preview == null:
		return
		
	selected_furniture.grid_anchor = preview_cell
	
	# CHECKS IF THE FURNITURE IS INSIDE THE HOUSE
	var available : bool = build_manager.find_furniture_availability(
		preview_cell,
		selected_furniture.size
	)
	
	if available:
		preview.modulate = Color.WHITE
		can_place = true
	else:
		can_place = false
		preview.modulate = Color.DARK_RED
	
# USED WHEN PLACING FURNITURES
func place_furniture() -> void:
	if !can_place:
		print("Placement not Valid")
		return
	
	var furniture = selected_furniture.scene.instantiate()
	furniture.global_position = preview.global_position
	
	furniture_container.add_child(furniture)
	
	# USED FOR CHECKING OCCUPIED SPACE
	furniture.grid_anchor = preview_cell
	furniture.size = selected_furniture.size
	
	player.input.state = player.input.STATES.NORMAL
	is_building = false
	preview.queue_free()
	saveload.save_furniture(global.save_slot)
	saveload.save_stats(global.save_slot)
	
