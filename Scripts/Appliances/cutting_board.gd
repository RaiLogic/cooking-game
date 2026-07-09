class_name CuttingBoard extends StaticBody2D


@onready var progress_bar: Panel = $Progress

@export var slice_time : float

func interact(interactor: Player) -> void:
	progress_bar.start(slice_time)
