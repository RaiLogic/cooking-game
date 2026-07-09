class_name InventoryComponent extends Node

var item_held : Food = null

signal item_changed(item)

func set_item(item: Food) -> void:
	item_held = item
	item_changed.emit(item)
