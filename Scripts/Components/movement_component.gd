class_name MovementComponent extends Node
 
@export var body : CharacterBody2D
@export var base_speed : float

@onready var speed : float = base_speed

var can_move : bool = true
var moving : bool

func move(move_direction: Vector2) -> void:
	if body == null:
		return
	
	if can_move:
		body.velocity.x = move_direction.x * speed 
		body.velocity.y = move_direction.y * speed
		
		if body.velocity != Vector2.ZERO:
			moving = true
		else: moving = false
		
		body.move_and_slide()
		
	
	
