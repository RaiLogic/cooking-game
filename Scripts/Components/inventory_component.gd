class_name InventoryComponent extends Node

var item_held : Food

signal item_changed(item)
signal full_inventory

func add_item(item: Food) -> bool:
	if item_held == null:
		item_held = item
		item_changed.emit(item)
		return true
	else:
		full_inventory.emit()
		return false

func replace_item(item: Food) -> void:
	item_held = item
	item_changed.emit(item)

func clear_item() -> void:
	item_held = null
	item_changed.emit(null)
