class_name EmotionSystem extends Control

# EMOTION SYSTEM | ONLY FOR SETTING THE EMOTION | THE CAUSE OF THE EMOTION WILL BE ON
# THE PARENT

var emotions : Array = get_children()

# THIS WILL BE CALLED AND BE BASED ON A SET STRING 'EMOTION'
func change_emotion(emotion: String) -> void:
	for i in emotions:
		emotions[i].visible = false
	
	match emotion:
		"happy":
			emotions[0].visible = true
		"neutral":
			emotions[1].visible = true
		"sad":
			emotions[2].visible = true
		"angry":
			emotions[3].visible = true
			
