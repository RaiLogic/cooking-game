class_name PlayerInventoryUI extends Control

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var inventory: TextureRect = $ItemHeld
@onready var food_name: Label = $FoodName
@onready var fridge: Panel = $FridgeUI

func set_inventory(item: Food) -> void:
	if item == null:
		inventory.visible = false
		food_name.visible = false
		return
	
	inventory.visible = true
	inventory.texture = item.icon
	
	food_name.visible = true
	food_name.text = item.food_name
	
func play_alert() -> void:
	animation.play("alert")
	
func fridge_ui(player: Player) -> void:
	if fridge.visible or !fridge.visible:
		fridge.visible = !fridge.visible
	
