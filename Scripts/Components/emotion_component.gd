class_name EmotionComponent extends Node2D

# THIS IS USED FOR CUSTOMER CHANGE OF EMOTION DEPENDING ON THE SATISFACTION LEVEL

var satisfaction : float = 100.0
var draining: bool = true
@onready var final_emotion: float = 0

enum STATES {
	HAPPY,
	NEUTRAL,
	SAD,
	ANGRY
}
var state: STATES

var main_state
var finished: bool

# REQUEST TO LEAVE OUT OF ANGER
signal request_leave

# EMOTION SPRITES
@onready var emotions = get_children()

func _ready() -> void:
	# THIS WILL MAKE THE CUSTOMER ALREADY HAPPY WHEN SPAWNING IN
	satisfaction = 100.0
	
	time.day_ended.connect(late_decrease)

func _process(delta: float) -> void:
	if draining:
		satisfaction_drain(delta) # DRAIN SATISFACTION
		change_emotion() # EMOTION CHECK
	
	if main_state == 3 and finished == false: # IF MAIN STATE IS NOT STATE.EATING
		final_emotion = done()
		draining = false
		finished = true

# IF CUSTOMER STILL WAITING AFTER CLOSING DAY, IT WILL DECREASE SATISFACTION
func late_decrease() -> void:
	satisfaction -= 15

# IF GOT INTERACTED, IT WILL INCREASE SATISFACTION
# CONNECTED TO CUSTOMER'S STATE_CHANGED SIGNAL
func interacted_increase() -> void:
	satisfaction += 10

func satisfaction_drain(delta: float) -> void:
	# SETTING THIS TO 0.7 WILL TAKE 36.71 SECONDS FOR AN EMOTION CHANGE
	if time.done:
		satisfaction -= 1 * delta
	else:
		satisfaction -= 0.7 * delta
	
	if satisfaction <= 0:
		if main_state != 4: # IF CUSTOMER STATE IS NOT STATE.LEAVING
			request_leave.emit()
	
func change_emotion() -> void:
	for i in emotions.size():
		emotions[i].visible = false
	
	if satisfaction >= 75:
		emotions[0].visible = true
		state = STATES.HAPPY
	elif satisfaction >= 50:
		emotions[1].visible = true
		state = STATES.NEUTRAL
	elif satisfaction >= 25:
		emotions[2].visible = true
		state = STATES.SAD
	else:
		emotions[3].visible = true
		state = STATES.ANGRY
		
func done() -> float:
	return satisfaction / 100
