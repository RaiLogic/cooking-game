extends StaticBody2D

signal opened

func interact(player: Player) -> void:
	opened.emit()
