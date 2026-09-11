extends Node

# USED IN SAVING AND LOADING PROGRESS 

const SAVE_LOCATION = "user://chef-legacy-save1.save"

var content: Dictionary = {
	"money": 0,
	"furniture": []
}

func save_game() -> void:
	var file := FileAccess.open(SAVE_LOCATION, FileAccess.WRITE)
	if file == null: print("Save Failed"); return
	
	content["money"] = global.total_money
	
	# REMOVE OLD FURNITURE DATA
	content["furniture"].clear()
	
	var furniture_container: Node2D = get_tree().current_scene.get_node(
		"World/Players/PlayerFurnitures"
	)
	
	# SAVE FURNITURE
	for furniture in furniture_container.get_children():
		content["furniture"].append({
			"scene": furniture.scene_file_path,
			"position": furniture.position
		})
	
	# TURNS DICTIONARY TO GODOT VARIANT DATA
	# TURNS VARIABLE TO SAVE FILE
	file.store_var(content.duplicate())
	
	file.close()
	print("Game Saved")
	
func load_game() -> void:
	# CHECK SAVE FILE IF AVAILABLE
	if !FileAccess.file_exists(SAVE_LOCATION):
		print("Load File not Found")
		return
		
	var file := FileAccess.open(SAVE_LOCATION, FileAccess.READ)
	# DOUBLE CHECK
	if file == null:
		print("File not Found")
		return
		
	# GET SAVE FROM VARIANT TO DICTIONARY
	var data: Dictionary = file.get_var()
	file.close()
	
	content = data.duplicate()
	global.total_money = content["money"]
	
	# LOAD FURNITURES
	var furniture_container : Node2D = get_tree().current_scene.get_node(
		"World/Players/PlayerFurnitures"
	)
	
	for furniture_data in content["furniture"]:
		var scene: PackedScene = load(furniture_data["scene"])
		var furniture := scene.instantiate()
		furniture.position = furniture_data["position"]
		furniture_container.add_child(furniture)
		
	print("Game Loaded")
