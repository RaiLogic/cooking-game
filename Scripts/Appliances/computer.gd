class_name Computer extends StaticBody2D

signal opened

var shop_ui: CanvasLayer

func interact(player: Player) -> void:
	shop_ui.show_ui(player)
