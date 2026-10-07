class_name PaymentComponent extends Node

var will_tip : bool
var tip_multiplier: float

# WILL GET FROM EMOTION_COMPONENT
var emotion_multiplier: float

func will_tip_rng() -> void:
	var rng = randi_range(1,3) # 1/3 CHANCE FOR THE CUSTOMER TO TIP
	if rng == 1:
		will_tip = true
	else:
		will_tip = false


		
