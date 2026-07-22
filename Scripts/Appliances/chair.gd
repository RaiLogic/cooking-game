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
	update_sprite()
	

func update_sprite() -> void:
	if placement == "left": left.visible = true;
	elif placement == "right": right.visible = true;
	elif placement == "down": down.visible = true;

func occupy(customer: Customer) -> void:
	occupied = true
	customer_sitting = customer
	
func remove(customer: Customer) -> void:
	if customer_sitting != customer:
		print("error")
		return

	print("Chair available")
	occupied = false
	customer_sitting = null
	
