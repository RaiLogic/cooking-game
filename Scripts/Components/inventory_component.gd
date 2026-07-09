class_name InventoryComponent extends Node

var item_held : Food

signal item_changed(item)

func set_item(item: Food) -> void:
	item_held = item
	item_changed.emit(item)

func clear_item() -> void:
	item_held = null
	item_changed.emit(null)
