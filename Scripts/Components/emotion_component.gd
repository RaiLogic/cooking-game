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

# EMOTION SPRITES
@onready var emotions = get_children()

func _ready() -> void:
	# THIS WILL MAKE THE CUSTOMER ALREADY HAPPY WHEN SPAWNING IN
	satisfaction = 100.0

func _process(delta: float) -> void:
	# SETTING THIS TO 0.4 WILL TAKE 62.5 SECONDS FOR AN EMOTION CHANGE
	satisfaction -= 0.4 * delta
	change_emotion()
	
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
