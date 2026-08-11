extends Control

@onready var slots: Array = $Slots.get_children()

@onready var animation: AnimationPlayer = $AnimationPlayer

var opened: bool = false

func _ready() -> void:
	GInput.order_pressed.connect(toggle)

func add_order(customer: Customer) -> void:
	for slot in slots:
		if slot.item_ui.texture == null:
			slot.item_ui.texture = customer.desired_food.icon
			return
			
func toggle() -> void:
	opened = !opened
	
	if opened: animation.play("up")
	else: animation.play("down")
