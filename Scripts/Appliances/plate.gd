class_name Plate extends StaticBody2D


@onready var progress_bar: Panel = $Progress

@export var plate_time : float

func interact(interactor: Player) -> void:
	progress_bar.start(plate_time)
