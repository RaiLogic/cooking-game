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

func _ready() -> void:
	timer.wait_time = customer_spawn_time
	
func spawn_customer() -> void:
	if customers.size() >= restaurant.chairs.size():
		return
	
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
	customer.state_changed.connect(chair.update_sprite)
	customer.has_ordered.connect(orders_ui.add_order)

# CALL WHEN READY TO SPAWN CUSTOMERS
func start_spawning() -> void:
	if timer.is_stopped():
		timer.start()

# CALLED WHEN THE CUSTOMER EMITS DONE SIGNAL
func customer_served(served: Customer) -> void:
	customers.erase(served)
	served.set_destination(main_point.global_position)

# SPAWNS THE CUSTOMER ON TIMER TIMEOUT, ALSO RANDOMIZES CUSTOMER SPAWN TIME
func _on_spawn_timer_timeout() -> void:
	spawn_customer()
	randomize_timer()

# FUNCTION TO RANDOMIZE CUSTOMER SPAWNING TIME
func randomize_timer() -> void:
	random_time = randf_range(2.0, 30.0)
	timer.wait_time = random_time
	print(random_time)
