extends Panel

@onready var bar: ProgressBar = $ProgressBar
@onready var invisible: Timer = $invisible

var running : bool
var time : float

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if running == true:
		bar.value += time * delta
	
	if bar.value >= 100:
		running = false
		
		if invisible.is_stopped(): 
			invisible.start()
		
func start(value: float) -> void:
	if running == false:
		visible = true
		running = true
		time = value
	

func _on_invisible_timeout() -> void:
	bar.value = 0
	visible = false
