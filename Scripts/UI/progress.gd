extends Panel

@onready var bar: ProgressBar = $ProgressBar

var running : bool
var time : float

signal finish

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if running == true:
		bar.value += time * delta
	
	if bar.value >= 100 and running == true:
		running = false
		finish.emit()

		
func start(value: float) -> void:
	if running == false:
		visible = true
		running = true
		time = value
		
func restart() -> void:
	bar.value = 0
	visible = false
