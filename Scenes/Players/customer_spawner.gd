class_name CustomerSpawner extends Node

@export var customer_scene : PackedScene
@export var menu : Resource

@onready var main_point: Marker2D = $MainPoint

# Timer Options
@onready var timer: Timer = $SpawnTimer
var random_time: float
@export var customer_spawn_time: float

var customers : Array = []
@onready var restaurant: Node = get_parent()
@onready var orders_ui: Control = %OrdersUI

# SOUND EFFECTS
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
const AMBIENCE = preload("uid://dr700vfxshku1")

func _ready() -> void:
	time.day_ended.connect(stop_spawning)

func spawn_customer() -> void:
	# IF ALL CHAIR ARE OCCUPIED
	if customers.size() >= restaurant.chairs.size():
		return
	
	if customers.size() == 3:
		ambience_start()
	elif customers.size() > 3:
		ambience_change()
	
	var customer = customer_scene.instantiate()

	customer.global_position = main_point.global_position
	customer.desired_food = menu.foods.pick_random() # PICK FOOD TO ORDER
	customer.state = customer.STATES.WALKING
	
	add_child(customer)
	customers.append(customer)
	
	# GET CHAIR TO SIT ON
	var chair = restaurant.get_available_chair()
	if chair:
		chair.occupy(customer)
		customer.set_destination(chair.sit_point.global_position)
	
	# SIGNAL CONNECTIONS
	customer.done.connect(customer_served)
	customer.done.connect(chair.remove)
	customer.done.connect(restaurant.money_added)
	customer.done.connect(restaurant.game_over)
	
	customer.state_changed.connect(chair.update_sprite)
	customer.has_ordered.connect(orders_ui.add_order)
	customer.eating.connect(orders_ui.remove_order)
	
	customer.leave_now.connect(customer_left)
	customer.leave_now.connect(chair.remove)

# CALL WHEN READY TO SPAWN CUSTOMERS
func start_spawning() -> void:
	if timer.is_stopped():
		timer.wait_time = 3.0
		timer.start()

# CALLED WHEN THE CUSTOMER EMITS DONE SIGNAL
func customer_served(served: Customer) -> void:
	if customers.size() == 0:
		ambience_stop()
	
	global.customer_served += 1
	customers.erase(served)
	served.set_destination(main_point.global_position)
	
func customer_left(left: Customer) -> void:
	if customers.size() == 0:
		ambience_stop()
	
	customers.erase(left)
	left.set_destination(main_point.global_position)

# SPAWNS THE CUSTOMER ON TIMER TIMEOUT, ALSO RANDOMIZES CUSTOMER SPAWN TIME
func _on_spawn_timer_timeout() -> void:
	spawn_customer()
	global.customer_count += 1
	randomize_timer()
	
	timer.start()
	
func ambience_start() -> void:
	print("Ambience Start")
	sfx_manager.play_sfx(audio, AMBIENCE, 0.0)
	ambience_change()
	
func ambience_change() -> void:
	print("Ambience Change")
	audio.volume_db = -30 + (customers.size() * 2)
	
func ambience_stop() -> void:
	print("Ambience Stop")
	sfx_manager.fade_out(audio, 5.0)

# FUNCTION TO RANDOMIZE CUSTOMER SPAWNING TIME
func randomize_timer() -> void:
	random_time = randf_range(5.0, 30.0)
	timer.wait_time = random_time

# STOPS SPAWNING CUSTOMERS | USED IN CLOSING TIME
func stop_spawning() -> void:
	timer.stop()
