class_name Refrigerator extends StaticBody2D

@export var food : Food

func interact(interactor: Player) -> void:
	interactor.inventory.set_item(food)
	print(food)
