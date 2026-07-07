class_name AnimationComponent extends Node

@export var sprite: AnimatedSprite2D

var direction : Vector2
var position : String = "up"

func action() -> void:
	position_update()
	
	if direction != Vector2(0,0):
		run()
	elif direction == Vector2(0,0):
		idle()

func run() -> void:
	if position == "right":
		sprite.play("right")
	elif position == "left":
		sprite.play("left")
	elif position == "up":
		sprite.play("up")
	elif position == "down":
		sprite.play("down")

func idle() -> void:
	if position == "right":
		sprite.play("idle:Right")
	elif position == "left":
		sprite.play("idle:Left")
	elif position == "up":
		sprite.play("idle:Up")
	elif position == "down":
		sprite.play("idle:Down")
	
func position_update() -> void:
	if direction.y == 0:
		if direction.x >= 1: position = "right"
		if direction.x <= -1: position = "left"
	
	elif direction.x == 0:
		if direction.y <= -1: position = "up"
		if direction.y >= 1: position = "down"
	
	
