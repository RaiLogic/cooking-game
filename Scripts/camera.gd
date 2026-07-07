extends Camera2D

@export var fixed : float = 640.0

func _process(delta: float) -> void:
	global_position.x = fixed
	print(global_position.x)
