extends Node

# USED IN SAVING AND LOADING PROGRESS 

const SAVE_LOCATION : Array[String] = [
	"user://chef-legacy-save1.save",
	"user://chef-legacy-save2.save",
	"user://chef-legacy-save3.save"
]

var content: Dictionary = {
	"money": 0,
	"furniture": [],
	"save_slot": 0,
	"team_name": "",
	"is_solo": 0
}

func save_stats(save_slot: int) -> void:
	# BASIC SYNTAX IN MAKING A SAVE FEATURE
	var file := FileAccess.open(SAVE_LOCATION[save_slot], FileAccess.WRITE)
	if file == null: print("Save Failed"); return
	
	content["money"] = global.total_money
	content["save_slot"] = global.save_slot
	content["team_name"] = global.team_name
	content["is_solo"] = global.single
	
	# TURNS DICTIONARY TO GODOT VARIANT DATA
	# TURNS VARIABLE TO SAVE FILE
	file.store_var(content.duplicate())
	
	
	file.close()
	# END SYNTAX OF MAKING A SAVE FEATURE
	print("Stat Saved on ", SAVE_LOCATION[save_slot])
	
func save_furniture(save_slot: int) -> void:
	if get_tree().current_scene.name != "House":
		return
	
	var file = FileAccess.open(SAVE_LOCATION[save_slot], FileAccess.WRITE)
	if file == null: print("Save Failed"); return
	
	var furniture_container: Node2D = get_tree().current_scene.get_node(
		"World/Players/PlayerFurnitures"
	)
	
	# REMOVE OLD FURNITURE DATA
	content["furniture"].clear()
	
	# SAVE FURNITURE
	for furniture in furniture_container.get_children():
		content["furniture"].append({
			"scene": furniture.scene_file_path,
			"position": furniture.position,
			"grid_anchor": furniture.grid_anchor,
			"size": furniture.size
		})
	
	file.store_var(content.duplicate())
	file.close()
	
	print("Furniture Saved on ", SAVE_LOCATION[save_slot])
	
	
func load_game(save_slot: int) -> void:
	# CHECK SAVE FILE IF AVAILABLE
	if !FileAccess.file_exists(SAVE_LOCATION[save_slot]):
		print("Load File not Found")
		return
		
	var file := FileAccess.open(SAVE_LOCATION[save_slot], FileAccess.READ)
	# DOUBLE CHECK
	if file == null:
		print("File not Found")
		return
		
	# GET SAVE FROM VARIANT TO DICTIONARY
	var data: Dictionary = file.get_var()
	file.close()
	
	content = data.duplicate()
	global.total_money = content["money"]
	global.single = content["is_solo"]
	global.save_slot = content["save_slot"]
	global.team_name = content["team_name"]
	
	# LOAD FURNITURES
	var furniture_container : Node2D = get_tree().current_scene.get_node(
		"World/Players/PlayerFurnitures"
	)
	
	for furniture_data in content["furniture"]:
		var scene: PackedScene = load(furniture_data["scene"])
		var furniture := scene.instantiate()
		furniture.position = furniture_data["position"]
		furniture_container.add_child(furniture)
		furniture.grid_anchor = furniture_data["grid_anchor"]
		furniture.size = furniture_data["size"]
		
	print("Game Loaded")

# CHECKS IF A SAVE EXISTS
func save_exists(slot: int) -> bool:
	return FileAccess.file_exists(SAVE_LOCATION[slot])
	
# GET THE SAVE DATA'S CONTENT
func get_save_data(slot: int) -> Dictionary:
	# CHECK IF SLOT IS VALID
	if slot < 0 or slot >= SAVE_LOCATION.size(): return {}
	
	# CHECK IF FILE EXISTS
	var path: String = SAVE_LOCATION[slot]
	if not FileAccess.file_exists(path): return {}
	
	# CHECK IF FILE HAS DATA INSIDE
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null: return {}
	
	var data = file.get_var()
	file.close()
	
	# CHECK IF DATA IS DICTIONARY
	if data is Dictionary:
		return data
		
	return {}
	
