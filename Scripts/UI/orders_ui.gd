extends Control

@onready var slots: Array = $Slots.get_children()
@onready var orders: Array[Dictionary] = []

@onready var animation: AnimationPlayer = $AnimationPlayer

var opened: bool = false

func _ready() -> void:
	GInput.order_pressed.connect(toggle)

func add_order(customer: Customer) -> void:
	for slot in slots:
		if slot.item_ui.texture == null:
			slot.item_ui.texture = customer.desired_food.icon
			
			# ADDS THE CUSTOMER AND THE FOOD SLOT HE IS IN
			orders.append({
			"customer": customer,
			"slot": slot
			})
			return
			
func remove_order(customer: Customer) -> void:
	if customer.state == customer.STATES.EATING:
		for order in orders: # GETS THE ORDERS IN THE ORDER LIST
			# IF THE CUSTOMER HAD RECEIVED THE ORDER, IT WILL GET THE RIGHT CUSTOMER
			# TO REMOVE ITS SLOT IN THE ORDER LIST
			if order["customer"] == customer: # GETS THE RIGHT CUSTOMER
				var slot = order["slot"] # LOOK FOR ITS SLOT
				slot.item_ui.texture = null
				orders.erase(order)
				return

func toggle() -> void:
	if animation.is_playing():
		return
		
	opened = !opened
	
	if opened: animation.play("up")
	else: animation.play("down")
	
	
