class_name EmotionComponent extends Node2D

# THIS IS USED FOR CUSTOMER CHANGE OF EMOTION DEPENDING ON THE SATISFACTION LEVEL

var satisfaction : float = 100.0

enum STATES {
	HAPPY,
	NEUTRAL,
	SAD,
	ANGRY
}
var state: STATES

signal leave_now

# EMOTION SPRITES
@onready var emotions = get_children()

func _ready() -> void:
	# THIS WILL MAKE THE CUSTOMER ALREADY HAPPY WHEN SPAWNING IN
	satisfaction = 100.0
	
	time.day_ended.connect(late_decrease)

func _process(delta: float) -> void:
	satisfaction_drain(delta) # DRAIN SATISFACTION
	change_emotion() # EMOTION CHECK

# IF CUSTOMER STILL WAITING AFTER CLOSING DAY, IT WILL DECREASE SATISFACTION
func late_decrease() -> void:
	satisfaction -= 15

# IF GOT INTERACTED, IT WILL INCREASE SATISFACTION
func interacted_increase() -> void:
	satisfaction += 10

func satisfaction_drain(delta: float) -> void:
	# SETTING THIS TO 0.4 WILL TAKE 62.5 SECONDS FOR AN EMOTION CHANGE
	if time.done:
		satisfaction -= 1 * delta
	else:
		satisfaction -= 0.4 * delta
	
func rage_quit() -> void:
	leave_now.emit()
		
	
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
