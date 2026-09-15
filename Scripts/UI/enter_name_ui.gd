extends CanvasLayer

@onready var confirm: Button = $Confirm/ConfirmButton

@onready var line: LineEdit = $LineEdit

signal done

func _ready() -> void:
	confirm.pressed.connect(func(): _on_name_submitted(line.text))

func _on_name_submitted(new_text: String) -> void:
	global.team_name = new_text
	done.emit()
