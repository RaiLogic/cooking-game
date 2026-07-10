class_name InteractedComponent extends Area2D

@export var interactable : Node2D

var interacted : bool

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.interact.set_interacted(self)
		print("enter")


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.interact.clear_interacted(self)
		print("exit")


func interact(interactor: Player) -> void:
	interactable.interact(interactor)
