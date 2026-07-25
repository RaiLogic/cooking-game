class_name CuttingBoard extends StaticBody2D

@onready var sound_player: AudioStreamPlayer = $AudioStreamPlayer
const slicing_sound = preload("res://Assets/Music/Slicing Sound Effect.mp3")

@onready var progress_bar: Panel = $Progress
@onready var tool_inventory: Panel = $ToolInventoryUI

@export var cook_time : float

var item : Food
var player : Player

enum STATES {
	EMPTY,
	SLICING,
	FULL
}

var current_state : int = STATES.EMPTY

func _ready() -> void:
	progress_bar.finish.connect(finished)

func interact(interactor: Player) -> void:
	player = interactor
	match current_state:
		STATES.EMPTY:
			if check_item():
				current_state = STATES.SLICING
				player.inventory.clear_item()
				player.interact.interacting = true
				slice()
		STATES.SLICING:
			tool_inventory.play_alert()
		STATES.FULL:
			if player.inventory.has_item():
				player.inventory.request_alert()
			else:
				player.inventory.add_item(item.sliced_version)
				restart()

func check_item() -> bool:
	if player.inventory.has_item():
		if player.inventory.item_held.can_slice:
			item = player.inventory.item_held
			return true
		else:
			player.inventory.request_alert()
			return false
	else:
		player.inventory.request_alert()
		return false
	

func slice() -> void:
	sfx_manager.play_sfx(sound_player, slicing_sound)
	tool_inventory.visible = true
	tool_inventory.set_ui(item)
	progress_bar.start(item.slice_time)
	
func finished() -> void:
	sfx_manager.stop(sound_player)
	player.interact.interacting = false
	tool_inventory.set_ui(item.sliced_version)
	current_state = STATES.FULL
	
func restart() -> void:
	current_state = STATES.EMPTY
	tool_inventory.clear_ui()
	progress_bar.restart()
	
