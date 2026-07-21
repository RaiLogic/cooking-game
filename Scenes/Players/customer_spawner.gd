class_name CustomerSpawner extends Node

@export var customer_scene : PackedScene
@export var menu : Resource

@onready var host: HostStand = $HostStand
@onready var queue_points: Array = $QueuePoints.get_children()
@onready var main_point: Marker2D = $MainPoint
@onready var timer: Timer = $SpawnTimer

var customers : Array = []

func _ready() -> void:
	
	if timer.is_stopped():
		timer.start()

func spawn_customer() -> void:
	if customers.size() >= queue_points.size():
		return
	
	var customer = customer_scene.instantiate()
	customer.global_position = main_point.global_position
	customer.desired_food = menu.foods.pick_random()
	customer.arrived.connect(update_order)
	add_child(customer)
	customers.append(customer)

	update_queue()
	
func update_order() -> void:
	var first_customer = customers[0]
	first_customer.show_order()

func update_queue() -> void:
	for queue in customers.size():
		customers[queue].set_destination(queue_points[queue].global_position)
		
	
func customer_served() -> void:
	var served = customers.pop_front()
	served.is_leaving = true
	served.queue_free()
	update_queue()

func _on_spawn_timer_timeout() -> void:
	spawn_customer()
