extends CanvasLayer

# STATS ALL ARE IN NEED TO EDIT FOR SUMMARY
@onready var customer: Label = $Info/Customer/Count
@onready var served: Label = $Info/Served/Count
@onready var earned: Label = $Info/Earned/Count
@onready var house_rent: Label = $Info/HouseRent/Count
@onready var restaurant: Label = $Info/RestaurantRent/Count
@onready var total_money: Label = $Info/TotalMoney/Count

@onready var button: Button = $Continue/Button

func _ready() -> void:
	# SETS THE WHOLE STATS
	customer.text = str(global.customer_count)
	served.text = str(global.customer_served)
	earned.text = str(global.earned_money)
	house_rent.text = str(global.house_rent)
	restaurant.text = str(global.restaurant_rent)
	customer.text = str(global.customer_count)
	
	total_money.text = str(global.total_money)
	
	button.pressed.connect(go_home)
	
func go_home() -> void:
	global.reset_stats()
	fade.change_scene("res://Scenes/Map/house.tscn", 2.5)
