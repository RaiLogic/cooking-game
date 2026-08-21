extends CanvasLayer

# COLOR BLACK IN FADING
@onready var black: ColorRect = $ColorRect
signal done_out # SIGNAL WHEN FADE OUT IS DONE
signal done_in # SIGNAL WHEN FADE IN IS DONE

# TURNING OFF BLACK SCREEN
func fade_in(duration: float) -> void:
	visible = true
	black.modulate.a = 1.0
	
	var tween = create_tween()
	tween.tween_property(black, "modulate:a", 0.0, duration)
	
	await tween.finished
	visible = false
	done_in.emit()

# TURNING ON BLACK SCREEN
func fade_out(duration: float) -> void:
	visible = true
	black.modulate.a = 0.0
	
	var tween = create_tween()
	tween.tween_property(black, "modulate:a", 1.0, duration)
	
	await tween.finished
	done_out.emit()

# FOR FASTER AND LESS CODE, JUST PUT THE WHOLE THING IN ONE FUNCTION AND
# ONE DURATION
func change_scene(path: String, duration: float) -> void:
	await fade_out(duration)
	get_tree().change_scene_to_file(path)
	fade_in(duration)
	
