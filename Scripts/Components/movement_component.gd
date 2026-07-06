class_name MovementComponent extends Node
 
@export var body : CharacterBody2D
@export var base_speed : float = 200.0

var speed : float = base_speed
var direction: Vector2 = Vector2.ZERO

func do(delta: float) -> void:
	if body == null:
		return
	
	body.velocity.x = direction.x * speed 
	body.velocity.y = direction.y * speed
	
	body.move_and_slide()
	 
	
