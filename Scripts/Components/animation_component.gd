class_name AnimationComponent extends Node

@export var sprite: AnimatedSprite2D

var position : String = "up"
var movement: Vector2

var dancing : bool

func update_anim(velocity: Vector2) -> void:
	movement = velocity
	
	position_update()
	if !dancing:
		if movement == Vector2.ZERO:
			idle()
		if movement != Vector2(0,0):
			dancing = false  
			run()
	elif movement != Vector2(0,0) and dancing:
		dancing = false

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
	if movement.x == 0:
		if movement.y <= -1: position = "up"
		if movement.y >= 1: position = "down"
	
	if movement.y == 0:
		if movement.x >= 1: position = "right"
		if movement.x <= -1: position = "left"
	
func dance() -> void:
	if movement == Vector2.ZERO:
		position = "down"
		dancing = true
		sprite.play("dance")
		
		await sprite.animation_finished
		dancing = false
		
		
		
	
	
