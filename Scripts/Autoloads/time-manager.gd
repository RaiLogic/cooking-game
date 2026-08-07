extends Node

signal time_changed(hour: int, minute: int)
signal day_ended

@onready var timer: Timer = Timer.new()

# HOW LONG WILL IT TAKE BEFORE TIME_PROGRESS
const REAL_SECOND_STEP : float = 0.1
# HOW MUCH TIME WILL PASS EVERY EVERY REAL SECONDS
const TIME_PROGRESS: int = 10

var hour : int = 8
var minute : int = 0
var is_morning : bool = true


	

func _ready() -> void:
	add_child(timer)
	timer.wait_time = REAL_SECOND_STEP
	timer.timeout.connect(_update_time)
	day_ended.connect(func (): print("Day Ended"))
	start_day()
	
func start_day() -> void:
	timer.start()
	
func _update_time() -> void:
	
	minute += TIME_PROGRESS
	
	if minute >= 60:
		hour += 1
		minute = 0
		
	time_changed.emit(hour, minute)
	print("Time: ", hour, ":%02d" % minute)
	if hour >= 18:
		day_ended.emit()
		timer.stop()
		
	
	
