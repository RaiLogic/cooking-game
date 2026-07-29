extends Panel

@onready var music_slider: HSlider = $Music/HSlider
@onready var sfx_slider: HSlider = $SFX/HSlider
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func center_window() -> void:
	var screen = DisplayServer.screen_get_size()
	get_window().position = (screen - get_window().size) / 2

func _on_back_button_pressed() -> void:
	visible = false


func _on_option_button_item_selected(index: int) -> void:
	match index:
		0:
			get_window().size = Vector2i(640, 360)
			center_window()
		1:
			get_window().size = Vector2i(1280, 720)
			center_window()
		2:
			get_window().size = Vector2i(1920, 1080)
			center_window()


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"),
		value
	)

func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	pass
	
func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		value
	)
