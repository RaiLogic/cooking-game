extends Node2D

@onready var floor: TileMapLayer = $Floor

# PLAYER 1 AND 2 BUILD COMPONENTS
@export var build_1 : BuildComponent
@export var build_2 : BuildComponent

# INTERACTABLES
@onready var leave_house: Area2D = $"../../LeaveHouse"
@onready var computer_area: Area2D = $"../Furnitures/Interactable/Computer".get_node(
	"InteractedComponent"
)

# USED TO CHECK IF THE BUILD WILL BE COLLIDED WITH AN ALREADY PLACED FURNITURE
@onready var furniture_container: Node2D = %PlayerFurnitures

var build_mode: bool = true

func _process(delta: float) -> void:
	if build_1.is_building:
		set_interactions(false)
	elif build_2 != null:
		if build_2.is_building:
			set_interactions(false)
	else:
		set_interactions(true)
	
func set_interactions(allowed: bool) -> void:
	leave_house.monitoring = allowed
	computer_area.monitoring = allowed
	
func find_furniture_availability(anchor: Vector2i, furniture_size: Vector2i) -> bool:
	if !is_inside_buildable_area(anchor, furniture_size):
		return false
	
	if is_occupied(anchor, furniture_size):
		return false
	
	return true

# CHECKS IF THE FURNITURE IS INSIDE THE BUILDABLE AREA OR IF INSIDE HOUSE
func is_inside_buildable_area(anchor: Vector2i, furniture_size: Vector2i) -> bool:
	# CHECKS THE SPACE NEEDED FOR THE SIZE OF FURNITURE_SIZE
	for x in range(furniture_size.x):
		for y in range(furniture_size.y):
			
			# CELL IS THE FINAL SPACE NEEDED FOR THE FURNITURE
			var cell := anchor + Vector2i(x, y)
			
			# IF THE SPACE OF THE FURNITURE (CELL) IS OUTSIDE THE BUILDABLE FLOOR
			if floor.get_cell_source_id(cell) == -1:
				return false
				
	# RETURN TRUE MEANS THE AREA IS BUILDABLE
	return true
	
func is_occupied(anchor: Vector2i, furniture_size: Vector2i) -> bool:
	# GETS EVERY CHILDREN IN CONTAINER FOR LATER
	for furniture in furniture_container.get_children():
		# CHECKS THE SPACE NEEDED FOR THE SIZE OF FURNITURE_SIZE
		for x in range(furniture_size.x):
			for y in range(furniture_size.y):
				
				# CELL IS THE FINAL SPACE NEEDED FOR THE FURNITURE
				var cell := anchor + Vector2i(x, y)
				
				for fx in range(furniture.size.x):
					for fy in range(furniture.size.y):
						var occupied_cell : Vector2i = (
							furniture.grid_anchor + Vector2i(fx, fy)
						)
						
						if cell == occupied_cell:
							return true
		
	
	return false
	

				
