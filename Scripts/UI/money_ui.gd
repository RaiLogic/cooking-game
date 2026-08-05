extends Control

@onready var money: Label = $Panel/Money

func _ready() -> void:
	global.money_changed.connect(change_value)
	change_value(global.money)

func change_value(value: int) -> void:
	money.text = str(value)
