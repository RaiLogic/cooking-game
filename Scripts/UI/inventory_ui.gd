extends Control

@onready var p1_inventory: TextureRect = $P1/ItemBorder/ItemHeld1
@onready var p2_inventory: TextureRect = $P2/ItemBorder/ItemHeld2

func set_inventory_1(item: Food) -> void:
	if item == null:
		p1_inventory.visible = false
		return
	
	p1_inventory.visible = true
	p1_inventory.texture = item.icon
	
func set_inventory_2(item: Food) -> void:
	if item == null:
		p2_inventory.visible = false
		return
		
	p2_inventory.visible = true
	p2_inventory.texture = item.icon
