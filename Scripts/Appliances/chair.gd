class_name Chair extends StaticBody2D

@export var placement : String

@onready var left: Node2D = $Unoccupied/Left
@onready var down: Node2D = $Unoccupied/Down
@onready var right: Node2D = $Unoccupied/Right

@onready var animation: AnimatedSprite2D

@onready var sit_point: Marker2D = $Point

var occupied : bool = false
var customer_sitting : Customer

func _ready() -> void:
	down.visible = false
	update_sprite(false)
	
func occupy(customer: Customer) -> void:
	occupied = true
	customer_sitting = customer
	animation = customer_sitting.skin.selected_skin

# CONNECTED TO CUSTOMER SIGNAL "done"
func remove(customer: Customer) -> void:
	update_sprite(false)
	
	if customer_sitting != customer:
		print("error")
		return

	occupied = false
	customer_sitting = null
	
#region ANIMATION SPRITE
func update_sprite(seated: bool) -> void:
	if !seated and customer_sitting == null:
		not_occupied()
		return
		
	animation.visible = true
	
	left.visible = false
	right.visible = false
	down.visible = false
	sitting()
	
func not_occupied() -> void:
	if placement == "left": 
		left.visible = true;
	elif placement == "right": 
		right.visible = true;
	elif placement == "down": 
		down.visible = true;
			
func sitting() -> void:
	if placement == "left":
		animation.play("sitting:Left")
		animation.stop()
		animation.frame = 0
	elif placement == "right":
		animation.play("sitting:Right")
		animation.stop()
		animation.frame = 0
	elif placement == "down":
		animation.play("sitting:Down")
		animation.stop()
		animation.frame = 0

func eating() -> void:
	if placement == "left":
		animation.play("sitting:Left")
	elif placement == "right":
		animation.play("sitting:Right")
	elif placement == "down":
		animation.play("sitting:Down")
#endregion
	
