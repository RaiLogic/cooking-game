extends Camera2D

@export var p2: Player
@export var p1: Player

# FIXED POINT TO NOT MOVE HORIZONTALLY
@export var fixed : float = 640.0
@export var is_fixed: bool

@export var min_zoom : float = 3.5
@export var max_zoom : float = 2.5
@export var max_distance : float = 200

var distance : float
var target_zoom : Vector2
var smoothness : float = position_smoothing_speed

func _process(delta: float) -> void:
	follow_zoom(delta)
	
	if is_fixed:
		fix_horizontal_follow()
	
func fix_horizontal_follow() -> void:
	global_position.x = fixed

func follow_zoom(delta: float) -> void:
	distance = p1.global_position.distance_to(p2.global_position)
	# get distance between player 1 and 2
	
	global_position = (p1.global_position + p2.global_position) / 2.0
	# maintain camera in the middle of player 1 and 2
	
	var t = clamp(distance / max_distance, 0.0, 1.0)
	# limits zoom so it won't be all zoomed out even if players 
	# get too far away
	
	target_zoom = Vector2.ONE * lerp(min_zoom, max_zoom, t)
	# Adjusts zoom depending on the distance of the 2 players
	# while limiting the zoom between min and max zoom
	
	zoom = zoom.lerp(Vector2.ONE * target_zoom, delta * smoothness)
	# Delays updates to make zoom smoother
	
	position = position.round()
