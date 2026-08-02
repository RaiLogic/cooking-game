class_name Chair extends StaticBody2D

@export var placement : String

@onready var left: Node2D = $Unoccupied/Left
@onready var down: Node2D = $Unoccupied/Down
@onready var right: Node2D = $Unoccupied/Right

@onready var animation: AnimatedSprite2D = $Occupied

@onready var sit_point: Marker2D = $Point

var occupied : bool = false
var customer_sitting : Customer

func _ready() -> void:
	down.visible = false
	update_sprite(false)
	

func update_sprite(seated: bool) -> void:
	if !seated:
		if placement == "left": 
			left.visible = true;
		elif placement == "right": 
			right.visible = true;
		elif placement == "down": 
			down.visible = true;
	else:
		left.visible = false
		right.visible = false
		down.visible = false
		
		animation.visible = true
		
		if placement == "left": 
			left.visible = true
		elif placement == "right": 
			right.visible = true
		elif placement == "down": 
			animation.play("down")
			print("seated")

func occupy(customer: Customer) -> void:
	occupied = true
	customer_sitting = customer

# CONNECTED TO CUSTOMER SIGNAL "done"
func remove(customer: Customer) -> void:
	update_sprite(false)
	
	if customer_sitting != customer:
		print("error")
		return

	occupied = false
	customer_sitting = null
	
