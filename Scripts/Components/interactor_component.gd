class_name InteractorComponent extends Node

var key_pressed : bool
var type : String

var current_interacted: InteractedComponent = null

func set_interacted(interacted: InteractedComponent) -> void:
	current_interacted = interacted

func clear_interacted(interacted: InteractedComponent) -> void:
	if current_interacted == interacted:
		current_interacted = null

func action() -> void:
	if current_interacted != null:
		type = current_interacted.type
	
	if key_pressed:
		if type == "refrigerator":
			refrigerator()

func refrigerator() -> void:
	if type == "refrigerator":
		print(type, "!")
