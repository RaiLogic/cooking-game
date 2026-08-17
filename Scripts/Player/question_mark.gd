class_name QuestionMark extends Node2D

# USED FOR CUSTOMERS OR OTHER NPCS IF THEIR INTERACTION IS IMPORTANT

@onready var animation: AnimationPlayer = $AnimationPlayer

func show_mark() -> void:
	visible = true
	animation.play("show")

func hide_mark() -> void:
	visible = false
	animation.stop()
