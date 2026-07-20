class_name HostStand extends StaticBody2D

@export var spawner : CustomerSpawner 

func interact(interactor: Player) -> void:
	if spawner.customers.is_empty():
		return
	
	var customer = spawner.customers[0]
	
	if !customer.agent.is_navigation_finished():
		return
		
	print("Customer wants: ", customer.desired_food)
	
