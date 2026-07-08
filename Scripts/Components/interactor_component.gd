class_name InteractorComponent extends Node

var type : String
var current_interacted: InteractedComponent = null

func set_interacted(interacted: InteractedComponent) -> void:
	current_interacted = interacted

func clear_interacted(interacted: InteractedComponent) -> void:
	if current_interacted == interacted:
		current_interacted = null

func action(interactor: Player) -> void:
	if current_interacted != null:
		current_interacted.interact(interactor)
