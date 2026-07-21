class_name CustomerSpawner extends Node

@export var customer_scene : PackedScene
@export var menu : Resource

@onready var main_point: Marker2D = $MainPoint
@onready var timer: Timer = $SpawnTimer

var customers : Array = []
@onready var restaurant = get_parent()

func _ready() -> void:
	if timer.is_stopped():
		timer.start()

func spawn_customer() -> void:
	if customers.size() >= restaurant.chairs.size():
		return
	
	var customer = customer_scene.instantiate()

	customer.global_position = main_point.global_position
	customer.desired_food = menu.foods.pick_random()
	customer.state = customer.STATES.WALKING
	customer.done.connect(customer_served)
	add_child(customer)
	customers.append(customer)
	
	var chair = restaurant.get_available_chair()
	if chair:
		chair.occupy(customer)
		customer.set_destination(
			chair.sit_point.global_position
		)

func customer_served(served: Customer) -> void:
	served.state = served.STATES.LEAVING
	served.queue_free()

func _on_spawn_timer_timeout() -> void:
	spawn_customer()
