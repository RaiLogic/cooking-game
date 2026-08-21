extends Node

#region STATS
# WILL ALSO BE USED IN THE SUMMARY SCENE

# TOTAL MONEY YOU HAVE
var total_money: int = 0

# HOW MANY CUSTOMERS WENT IN THE RESTAURANT
var customer_count : int = 0 

# HOW MANY CUSTOMERS HAS BEEN SERVED
var customer_served: int = 0 

# EARNED MONEY IN THE DAY
var earned_money: int

# HOUSE RENT HOW MUCH YOU PAY EVERY END OF DAY
var house_rent: int = 100

# RESTAURANT RENT HOW MUCH YOU PAY EVERY END OF DAY
var restaurant_rent: int = 150
#endregion

signal money_changed(amount)

enum LOCATIONS {
	MAIN_MENU,
	RESTAURANT,
	HOUSE
}

var current_location : int = LOCATIONS.MAIN_MENU

func _ready() -> void:
	# DEVELOPING, REMOVED MUSIC
	#AudioServer.set_bus_volume_db(
		#AudioServer.get_bus_index("Music"),
		#-80
	#)
	
	time.day_ended.connect(end_day)

func set_location(location):
	current_location = location
	
	match current_location:
		LOCATIONS.MAIN_MENU:
			music_manager.play_music(music_manager.MENU)
		LOCATIONS.RESTAURANT:
			music_manager.play_music(music_manager.INGAME)
			
func add_money(amount) -> void:
	earned_money += amount
	total_money += amount
	money_changed.emit(earned_money)
	
func spend_money(amount) -> void:
	if total_money < amount:
		print("Not Enough Money!")
		return

# WHEN DAY ENDING AND RESTAURANT WILL RESET, THIS WILL RESET THE SUMMARY STATS
func reset_stats() -> void:
	customer_count = 0
	customer_served = 0
	earned_money = 0
	
func end_day() -> void:
	pay_rent()

func pay_rent() -> void:
	total_money -= house_rent + restaurant_rent
	
