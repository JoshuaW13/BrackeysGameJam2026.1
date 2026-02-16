extends Node
class_name Inventory

@export var inventory_spawn: Marker2D
var inventory: Array[Item] = []

func _ready() -> void:
	for i in range(3):
		var box_item : Item = preload("res://entities/box/box.tres")
		add_item(box_item)

func add_item(item: Item)->void:
	var spawn_front: bool = inventory.is_empty()
	inventory.push_back(item)
	if spawn_front:
		var selected_item_scene: PackedScene = preload("res://common/components/Inventory/InventoryItem.tscn")
		var item_instance : InventoryItem = selected_item_scene.instantiate()
		inventory_spawn.add_child(item_instance)
		item_instance.item_resource = inventory.front()

func remove_item()->void:
	pass
