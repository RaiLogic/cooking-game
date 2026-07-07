class_name InteractedComponent extends Area2D

@export var type : String

var interacted : bool

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.interact.set_interacted(self)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.interact.clear_interacted(self)
