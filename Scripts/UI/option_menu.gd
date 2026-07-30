extends Panel

@onready var music_slider: HSlider = $Music/HSlider
@onready var sfx_slider: HSlider = $SFX/HSlider
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var last_size: Vector2i
var last_mode: Window.Mode

@onready var res_button: OptionButton = $Resolution/ResolutionButton
@onready var window_button: OptionButton = $Window/WindowButton

@onready var window : Window = get_window()

func _ready() -> void:
	last_size = window.size
	last_mode = window.mode

func _process(delta: float) -> void:
	var size: Vector2i = window.size
	var mode: Window.Mode = window.mode
	
	if size != last_size or mode != last_mode:
		last_size = size
		last_mode = mode
		update_res_option()
		
func update_res_option() -> void:
	if window.mode == Window.MODE_FULLSCREEN:
		res_button.disabled = true
		res_button.text = "FULLSCREEN"
		return
		
	res_button.disabled = false
	
	match window.size:
		Vector2i(640, 360):
			res_button.text = "640×360"
		Vector2i(1280, 720):
			res_button.text = "1280×720"
		Vector2i(1920, 1080):
			res_button.text = "1920×1080"
		_:
			res_button.text = str(window.size.x) + "x" + str(window.size.y)
	

func center_window() -> void:
	var screen = DisplayServer.screen_get_size()
	get_window().position = (screen - get_window().size) / 2

func _on_back_button_pressed() -> void:
	visible = false


func _on_option_button_item_selected(index: int) -> void:
	match index:
		0:
			window.set_size(Vector2i(640, 360))
			center_window()
		1:
			window.set_size(Vector2i(1280, 720))
			center_window()
		2:
			window.set_size(Vector2i(1920, 1080))
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


func _on_window_button_item_selected(index: int) -> void:
	match index:
		0: # BORDERLESS
			window.mode = Window.MODE_WINDOWED
			window.borderless = true
		1: # WINDOWED
			window.mode = Window.MODE_WINDOWED
			window.borderless = false
		2:
			window.mode = Window.MODE_FULLSCREEN
