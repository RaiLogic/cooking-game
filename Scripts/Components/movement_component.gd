class_name MovementComponent extends Node
 
@export var body : CharacterBody2D
@export var base_speed : float

var speed : float = base_speed
var direction: Vector2 = Vector2.ZERO
var can_move : bool

func move() -> void:
	if body == null:
		return
		
	
	if can_move:
		body.velocity.x = direction.x * speed 
		body.velocity.y = direction.y * speed
		
		body.move_and_slide()
	 
	
