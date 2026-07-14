class_name InventoryComponent extends Node

var item_held : Food

signal item_changed(item)
signal action_failed

func request_alert() -> void:
	action_failed.emit()

func has_item() -> bool:
	if item_held != null:
		return true
	else:
		return false

func add_item(item: Food) -> bool:
	if item_held == null:
		item_held = item
		item_changed.emit(item)
		return true
	else:
		return false

func replace_item(item: Food) -> void:
	item_held = item
	item_changed.emit(item)

func clear_item() -> void:
	item_held = null
	item_changed.emit(null)
