class_name DashComponent extends Node


@onready var dashing: Timer = $Dashing
@onready var dash_time: Timer = $DashCooldown

var speed_multiplier: int = 5
var dash_moving: bool = false
var dash_cd: bool = false

func dash_action() -> void:
	if !dash_cd:
		dash_cd = true
		dashing.start()
		dash_moving = true

func _on_dashing_timeout() -> void:
	dash_time.start()
	dash_moving = false
	
func _on_dash_cooldown_timeout() -> void:
	dash_cd = false
