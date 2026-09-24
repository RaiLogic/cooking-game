extends Node

# USED TO CHECK IF THE WHOLE TIMER IS DONE
var done: bool = false

signal time_changed(hour: int, minute: int)
signal day_ended

@onready var timer: Timer = Timer.new()

# HOW LONG WILL IT TAKE BEFORE TIME_PROGRESS
const REAL_SECOND_STEP : float = 5
# HOW MUCH TIME WILL PASS EVERY EVERY REAL SECONDS
const TIME_PROGRESS: int = 10

# TIME START SETTING
@onready var hour : int
@onready var minute : int
@onready var is_morning : bool

func _ready() -> void:
	add_child(timer)
	timer.wait_time = REAL_SECOND_STEP
	timer.timeout.connect(_update_time)
	day_ended.connect(func(): print("Closing Time"))
	
	global.game_over.connect(stop_timer)
	
func start_day() -> void:
	done = false
	is_morning = true
	hour = 12
	minute = 0
	time_changed.emit(hour, minute)
	timer.start()
	
	# DEVELOPMENT | FINISH DAY IMMEDIATELY
	#is_morning = false
	#hour = 7
	#minute = 30
	
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
		done = true
		day_ended.emit()
		
	time_changed.emit(hour, minute)

# STOPS THE CLOCK
func stop_timer() -> void:
	timer.stop()
