extends Node

# USED IN SAVING AND LOADING PROGRESS 

const SAVE_LOCATION = "user://chef-legacy-save.json"

var content: Dictionary = {
	
}

func save_game() -> void:
	# OPENS OR MAKE THE FILE IN THE SAVE_LOCATION
	var file = FileAccess.open(SAVE_LOCATION, FileAccess.WRITE)
	
	# WILL STORE THE CONTENT AS VARIABLES
	file.store_var(content.duplicate())
	file.close()
	
func load_game() -> void:
	var file = FileAccess.open(SAVE_LOCATION, FileAccess.READ)
	var data = file.get_var()
	file.close()
	
	var save_data = data.duplicate()
	
