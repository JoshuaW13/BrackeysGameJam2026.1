extends Node
class_name Inventory

@export var inventory_spawn: Marker2D
var inventory: Array[Item] = []
var current_item: InventoryItem

func _ready() -> void:
	pass
	for i in range(3):
		var box_item : Item = preload("res://entities/box/box.tres")
		add_item(box_item)

func add_item(item: Item)->void:
	inventory.push_back(item)
	spawn_front()

func remove_item()->void:
	inventory.pop_front()
	if current_item:
		current_item.queue_free()
		current_item = null
	spawn_front()

func use_item()->void:
	if !inventory.is_empty():
		var item_to_spawn : PackedScene = inventory.front().scene
		var item_instance : Box = item_to_spawn.instantiate()
		item_instance.position = inventory_spawn.global_position
		get_tree().current_scene.add_child(item_instance)
	remove_item()

func spawn_front()->void:
	var spawn_front: bool = !inventory.is_empty()
	if spawn_front:
		var selected_item_scene: PackedScene = preload("res://common/components/Inventory/InventoryItem.tscn")
		current_item = selected_item_scene.instantiate()
		inventory_spawn.add_child(current_item)
		current_item.item_resource = inventory.front()	
