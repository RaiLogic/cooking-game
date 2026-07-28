extends Control

func center_window() -> void:
	var screen := DisplayServer.window_get_current_screen()
	var screen_pos := DisplayServer.screen_get_position(screen)
	var screen_size := DisplayServer.screen_get_size(screen)

	var window_size := get_window().size

	var pos := screen_pos + (screen_size - window_size) / 2

	DisplayServer.window_set_position(pos)

func _on_options_button_pressed() -> void:
	print(get_window().size)
	get_window().size = Vector2i(1920, 1080)
	center_window()
