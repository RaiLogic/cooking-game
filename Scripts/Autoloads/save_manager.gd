extends Node

# USED IN SAVING AND LOADING PROGRESS 

const SAVE_LOCATION = "user://chef-legacy-save.json"

var content: Dictionary = {
	"money": 0,
	"furniture": []
}

func save_game() -> void:
	# OPENS OR MAKE THE FILE IN THE SAVE_LOCATION
	var file = FileAccess.open(SAVE_LOCATION, FileAccess.WRITE)
	
	content["money"] = global.total_money
	
	# USED TO GET tHE CONTAINER FOR FURNITURES PLACED BY THE PLAYER
	var furniture_container : Node2D = get_tree().current_scene.get_node(
		"World/Players/PlayersFurnitures"
	)
	
	# WILL GET EVERY FURNITURE FROM THE CONTAINER
	for furniture in furniture_container.get_children():
		content["furniture"].append({
			"scene": furniture.scene_file_path,
			"position": furniture.position
		})
	
	# WILL STORE THE CONTENT AS VARIABLES
	file.store_var(content.duplicate())
	file.close()
	
	print("Saved")
	
func load_game() -> void:
	var file = FileAccess.open(SAVE_LOCATION, FileAccess.READ)
	var data = file.get_var()
	file.close()
	
	var save_data = data.duplicate()
	
