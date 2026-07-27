extends StaticBody2D

@export var dance : String
@onready var animate: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animate.play(dance)
