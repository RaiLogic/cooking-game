class_name Stove extends StaticBody2D

@onready var sound_player: AudioStreamPlayer = $AudioStreamPlayer
var cooking_sfx = preload("uid://chib26i7gb8a")

@onready var progress_bar: Panel = $Progress
@onready var tool_inventory: Panel = $ToolInventoryUI

@export var cook_time : float

var item : Food
var player : Player

enum STATES {
	EMPTY,
	COOKING,
	FULL
}

var current_state : int = STATES.EMPTY

func _ready() -> void:
	progress_bar.finish.connect(finished)
	time.day_ended.connect(stop_everything)

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
		STATES.FULL:
			if player.inventory.has_item():
				player.inventory.request_alert()
			else:
				player.inventory.add_item(item.cooked_version)
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
	sfx_manager.play_sfx(sound_player, cooking_sfx, 0)
	sfx_manager.fade_in(sound_player, 0.5)
	tool_inventory.visible = true
	tool_inventory.set_ui(item)
	progress_bar.start(item.cook_time)
	
func finished() -> void:
	sfx_manager.fade_out(sound_player, 3.0)
	tool_inventory.set_ui(item.cooked_version)
	current_state = STATES.FULL
	
func restart() -> void:
	current_state = STATES.EMPTY
	tool_inventory.clear_ui()
	progress_bar.restart()

# MIGHT CHANGE THIS SOON
func stop_everything() -> void:
	sfx_manager.stop(sound_player)
	
