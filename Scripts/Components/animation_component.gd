class_name AnimationComponent extends Node

@export var sprite: AnimatedSprite2D

var direction : Vector2

func rotate_sprite() -> void:
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
