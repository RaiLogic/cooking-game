class_name Refrigerator extends StaticBody2D

@export var food_group : Array[Food]
var fridge_user : Player
var player : Player

var prev_food : Food
var curr_food : Food
var next_food : Food
var index : int = 0

func interact(interactor: Player) -> void:
	# AVOIDS MULTIPLE PLAYERS USING THE FRIDGE
	if fridge_user != null:
		if fridge_user == interactor:
			player.interact.fridge_toggle.emit(false)
			get_food()
			fridge_user = null
			return
		else:
			print("you're not ", fridge_user.name)
			return

	player = interactor
	fridge_user = player
	interactor.input.fridge_mode(self)
	
	update_fridge()
	player.interact.fridge_toggle.emit(true)

func get_food() -> void:
	player.inventory.replace_item(curr_food)

func update_fridge() -> void:
	# Sets the food carousel
	curr_food = food_group[index]
	prev_food = food_group[
		(index - 1 + food_group.size()) % food_group.size()
		]
	next_food = food_group[(index + 1) % food_group.size()]
	
	player.interact.fridge_food_rotate.emit(prev_food, curr_food, next_food)
	
func next() -> void:
	index += 1
	
	if index >= food_group.size():
		index = 0
		
	update_fridge()
	
func back() -> void:
	index -= 1
	if index < 0:
		index = food_group.size() - 1
		
	update_fridge()
	
