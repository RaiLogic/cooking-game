class_name Stove extends StaticBody2D


@onready var progress_bar: Panel = $Progress

@export var cooking_time : float

func interact() -> void:
	progress_bar.start(cooking_time)
	
