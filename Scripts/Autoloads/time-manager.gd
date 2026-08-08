extends Node

signal time_changed(hour: int, minute: int)
signal day_ended

@onready var timer: Timer = Timer.new()

# HOW LONG WILL IT TAKE BEFORE TIME_PROGRESS
const REAL_SECOND_STEP : float = 2
# HOW MUCH TIME WILL PASS EVERY EVERY REAL SECONDS
const TIME_PROGRESS: int = 10

@onready var hour : int = 8
@onready var minute : int = 0
@onready var is_morning : bool = true

func _ready() -> void:
	add_child(timer)
	timer.wait_time = REAL_SECOND_STEP
	timer.timeout.connect(_update_time)
	day_ended.connect(func(): print("Closing Time"))
	start_day()
	
func _process(delta: float) -> void:
	print("%02d:%02d" % [hour, minute])
	
func start_day() -> void:
	is_morning = true
	timer.start()
	
func _update_time() -> void:
	minute += TIME_PROGRESS
	
	if minute >= 60:
		hour += 1
		minute = 0
	
	# CONDITION WHEN MORNING
	if is_morning and hour >= 13:
		hour = 1
		minute = 0
		is_morning = false
	
	# CONDITION WHEN MID-DAY AND CLOSING
	if !is_morning and hour >= 8:
		day_ended.emit()
		timer.stop()
		
	time_changed.emit(hour, minute)
