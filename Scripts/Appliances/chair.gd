class_name Chair extends StaticBody2D

@export var placement : String
@onready var left: Node2D = $Placement/Left
@onready var down: Node2D = $Placement/Down
@onready var right: Node2D = $Placement/Right

@onready var sit_point: Marker2D = $Point

var occupied : bool = false
var customer_sitting : Customer

func _ready() -> void:
	down.visible = false
	
	if placement == "left": left.visible = true; print("left")
	elif placement == "right": right.visible = true; print("right")
	elif placement == "down": down.visible = true; print("down")
	
func occupy(customer: Customer) -> void:
	occupied = true
	customer_sitting = customer
	
func free() -> void:
	occupied = false
	customer_sitting = null
	
