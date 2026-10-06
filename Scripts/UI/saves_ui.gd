extends Control

@onready var save_buttons: Array[Button] = [
	$Save1/Button,
	$Save2/Button,
	$Save3/Button
]
@onready var save_labels: Array[Label] = [
	$Save1/Label,
	$Save2/Label,
	$Save3/Label
]

# USED FOR GETTING NEW SAVE FILE
signal register_done

# USED FOR LOADING SAVE FILE
signal game_loaded

func _ready() -> void:
	get_saves()

# CHECKS SAVE FILES AVAILABILITY | WILL DISABLE BUTTON WHEN SAVE FILE IS NOT AVAILABLE
func get_saves() -> void:
	for i in range(save_buttons.size()):
		save_buttons[i].pressed.connect(load_game.bind(i))
	
	for i in range(save_buttons.size()):
		if not saveload.save_exists(i):
			save_buttons[i].disabled = true
			save_labels[i].text = "No Save"
		elif saveload.save_exists(i):
			save_buttons[i].disabled = false
			var data = saveload.get_save_data(i)
			save_labels[i].text = data["team_name"]

# MAKES THE BUTTON CHANGE DEPENDING IF THE PLAYER PICKED NEW GAME OR LOAD GAME\
# NO USE YET
func new_game() -> void:
	pass
	
func load_game(save_slot: int) -> void:
	global.save_slot = save_slot
	game_loaded.emit()
	
			
func enable_save_slot_selection() -> void:
	for i in range(save_buttons.size()):
		save_buttons[i].pressed.disconnect(load_game)
		save_buttons[i].pressed.connect(confirm_save_slot.bind(i))
	
	for i in range(save_buttons.size()):
		if saveload.save_exists(i):
			save_buttons[i].disabled = true
			save_labels[i].text = "Occupied"
		else:
			save_buttons[i].disabled = false
			save_labels[i].text = "Slot " + str(i + 1)
		
func confirm_save_slot(slot: int) -> void:
	global.save_slot = slot
	register_done.emit()
		
