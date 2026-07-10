class_name PlayerInventoryUI extends Control

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var inventory: TextureRect = $ItemHeld

func set_inventory(item: Food) -> void:
	if item == null:
		inventory.visible = false
		return
		
	inventory.visible = true
	inventory.texture = item.icon
	
func play_alert() -> void:
	animation.play("alert")
