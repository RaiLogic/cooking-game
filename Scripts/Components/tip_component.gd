class_name TipComponent extends Node

var will_tip : bool
var tip_multiplier: float

# GETS VALUE FROM CUSTOMER.GD
var emotion_level : int

func _ready() -> void:
	check_will_tip()
	print(will_tip)
	
func check_will_tip() -> void:
	# THIS MAKES IT SO THAT THE CUSTOMER HAS 25% CHANCE TO TIP
	var rng = randf_range(0.0, 100.0)
	if rng >= 75.0:
		will_tip = true
	else:
		will_tip = false

func get_final_tip() -> bool:
	if will_tip:
		tip_multiplier = (emotion_level / 100.0)
		return tip_multiplier
	
	return 0.0
