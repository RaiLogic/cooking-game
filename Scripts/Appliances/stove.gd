class_name Stove extends StaticBody2D

@onready var cooking_player: AudioStreamPlayer = $CookingAudio
@onready var sfx_player: AudioStreamPlayer = $SFX
var cooking_sfx = preload("uid://chib26i7gb8a")
var done_sfx = preload("uid://ctvnvw2n2ydeh")

# PROGRESS BARS
@onready var cooking_progress: Panel = $Cooking
@onready var burnt_progress: Panel = $Burning

@onready var tool_inventory: Panel = $ToolInventoryUI

@export var cook_time : float
# HARD CODE TIME FOR WHEN FOOD IS BURNING | BURN TIME ~ 15
@onready var burnt_time: float = 4.5 

var item : Food
var player : Player
var burnt : bool = false

enum STATES {
	EMPTY,
	COOKING,
	FULL,
}

var current_state : int = STATES.EMPTY

func _ready() -> void:
	cooking_progress.finish.connect(finished)
	burnt_progress.finish.connect(food_burnt)
	global.game_over.connect(stop_everything)
	
	
	#region CHANGING COLOR OF BURNT PROGRESS BAR
	var burnt_progress_bar = burnt_progress.get_node("ProgressBar")
	var style = burnt_progress_bar.get_theme_stylebox("fill").duplicate()
	style.bg_color = Color.BLACK
	
	burnt_progress_bar.add_theme_stylebox_override("fill", style)
	#endregion
	

func interact(interactor: Player) -> void:
	player = interactor
	match current_state:
		STATES.EMPTY:
			if check_item():
				current_state = STATES.COOKING
				player.inventory.clear_item()
				cook()
		STATES.COOKING:
			tool_inventory.play_alert()
		STATES.FULL: # THIS IS WHEN THE PLAYER IS TAKING THE FOOD
			if player.inventory.has_item(): # IF PLAYER HAS FULL INVENTORY
				player.inventory.request_alert()
			else: # IF PLAYER HAS NO ITEM IN INVENTORY AND CAN GET THE COOKED ITEM
				if !burnt:
					player.inventory.add_item(item.cooked_version)
					item.burnt_multipler = get_burnt_percentage()
				else:
					player.inventory.add_item(item.burnt_version)
				
				sfx_manager.fade_out(cooking_player, 3.0)
				restart()
	

func check_item() -> bool:
	if player.inventory.has_item():
		if player.inventory.item_held.can_cook:
			item = player.inventory.item_held
			return true
		else:
			player.inventory.request_alert()
			return false
	else:
		player.inventory.request_alert()
		return false
	
func cook() -> void:
	sfx_manager.play_sfx(cooking_player, cooking_sfx, 0)
	sfx_manager.fade_in(cooking_player, 0.5)
	tool_inventory.visible = true
	tool_inventory.set_ui(item)
	cooking_progress.start(item.cook_time)

# THIS WILL GET THE VALUE OF HOW MUCH THE BURNT BAR IS FILLED UP
func get_burnt_percentage() -> float:
	var burnt_progress_bar = burnt_progress.get_node("ProgressBar")
	
	return burnt_progress_bar.value

# CHANGES THE FOOD TO A BURNT FOOD
func food_burnt() -> void:
	tool_inventory.set_ui(item.burnt_version)
	sfx_manager.fade_out(cooking_player, 3.0)
	burnt_progress.restart()
	burnt = true

# WHEN THE FOOD IS FINISHED AND READY TO BE TAKEN, THE COOKING WILL CONTINUE 
# BURNING THE FOOD
func finished() -> void:
	sfx_manager.play_sfx(sfx_player, done_sfx, 1.0)
	tool_inventory.set_ui(item.cooked_version)
	current_state = STATES.FULL
	cooking_progress.restart()
	burnt_progress.start(4.5)
	
func restart() -> void:
	current_state = STATES.EMPTY
	tool_inventory.clear_ui()
	cooking_progress.restart()
	burnt_progress.restart()
	burnt = false

# MIGHT CHANGE THIS SOON
func stop_everything() -> void:
	sfx_manager.stop(cooking_player)
	sfx_manager.stop(sfx_player)
	
