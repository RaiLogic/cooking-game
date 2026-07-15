class_name PlatingUI extends Control

@onready var slot1_ui: ToolInventoryUI = $Slot1
@onready var slot2_ui: ToolInventoryUI = $Slot2
@onready var slot3_ui: ToolInventoryUI = $Slot3
@onready var result: ToolInventoryUI = $Result

@onready var slot1: TextureRect = slot1_ui.get_node("TextureRect")
@onready var slot2: TextureRect = slot2_ui.get_node("TextureRect")
@onready var slot3: TextureRect = slot3_ui.get_node("TextureRect")

func set_item(index: int, item: Food) -> void:
	visible = true
	match index:
		1: slot1.texture = item.icon
		2: slot2.texture = item.icon
		3: slot3.texture = item.icon
		
func request_alert() -> void:
	slot1_ui.play_alert()
	slot2_ui.play_alert()
	slot3_ui.play_alert()

func clear_item(index: int) -> void:
	match index:
		1: slot1.texture = null
		2: slot2.texture = null
		3: slot3.texture = null
		
	if slot1.texture == null and slot2.texture == null and slot3.texture == null:
		visible = false	

func clear_all() -> void:
	slot1.texture = null
	slot2.texture = null
	slot3.texture = null
	result.item_ui.texture = null
	visible = false

func show_result(crafted_item: Food) -> void:
	result.item_ui.texture = crafted_item.icon
	
