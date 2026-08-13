class_name Restaurant extends Node

# PLAYERS
@onready var p1_ui: PlayerInventoryUI = $UI/P1InventoryUI
@onready var p2_ui: PlayerInventoryUI = $UI/P2InventoryUI

@onready var player_1: Player = %Player1
@onready var player_2: Player = %Player2

# CHAIRS
@onready var chairs: Array = $Interactables/Dining/Chairs.get_children()
var next_chair: int = 0

# ORDER UI
@onready var orders_ui: Control = $UI/OrdersUI

# CUSTOMER SPAWNER
@onready var customer_spawner: CustomerSpawner = $CustomerSpawner

# LOCATION
const LOCATION = global.LOCATIONS.RESTAURANT


func _ready() -> void:
	# SET MUSIC
	music_manager.play_music(music_manager.INGAME)
	
	# START DAY
	global.set_location(LOCATION)
	customer_spawner.start_spawning()
	time.start_day()
	
	# PLAYER SIGNALS
	player_signal_connections()

# USED FOR THE CUSTOMER FINDING ITS OWN CHAIR
# CONNECTED TO CUSTOMER_SPAWNER.GD
func get_available_chair() -> Chair:
# MAKES IT SO THAT CHAIRS WONT BE REUSED AND HAS TO CYCLE THROUGH EVERY CHAIR FIRST
	var count := chairs.size()

	for i in range(count):	
		var index: int = (next_chair + i) % count

		if chairs[index].customer_sitting == null:
			next_chair = (index + 1) % count
			return chairs[index]

	return null
	
func player_signal_connections() -> void:
	# PLAYER MOVEMENT
	player_1.input.state = 0 # 0 MEANS NORMAL MOVEMENT
	player_2.input.state = 0
	
	
	# show inventory to inventory ui
	player_1.inventory.item_changed.connect(p1_ui.set_inventory)
	player_2.inventory.item_changed.connect(p2_ui.set_inventory)
	
	# show alert when inventory is full
	player_1.inventory.action_failed.connect(p1_ui.play_alert)
	player_2.inventory.action_failed.connect(p2_ui.play_alert)
	
	#fridge ui interaction
	player_1.interact.fridge_toggle.connect(p1_ui.set_fridge_ui)
	player_2.interact.fridge_toggle.connect(p2_ui.set_fridge_ui)
	
	player_1.interact.fridge_food_rotate.connect(p1_ui.fridge_update_ui)
	player_2.interact.fridge_food_rotate.connect(p2_ui.fridge_update_ui)
	
	# Global Inputs Connection
	GInput.order_pressed.connect(orders_ui.toggle)
