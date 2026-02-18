extends Node
class_name Inventory

@export var inventory_spawn: Marker2D
@export var inventory_spawn_scale: Vector2 = Vector2(1, 1)
var inventory: Array[Item] = []
var current_item: InventoryItem

func _ready() -> void:
	pass
	for i in range(5):
		var new_item : Item
		if i%2==0:
			new_item = preload("res://entities/coffee/coffee.tres")
		else:
			new_item  = preload("res://entities/box/box.tres")
		add_item(new_item)

func add_item(item: Item)->void:
	inventory.push_back(item)
	if inventory.size() == 1:
		spawn_front()

func remove_item()->void:
	if inventory.is_empty():
		return
	inventory.pop_front()
	spawn_front()

func use_item()->void:
	if !inventory.is_empty():
		var item_to_spawn : PackedScene = inventory.front().scene
		var item_instance : RigidBody2D = item_to_spawn.instantiate()
		item_instance.position = inventory_spawn.global_position
		get_tree().current_scene.add_child(item_instance)
	remove_item()

func spawn_front()->void:
	if current_item:
		current_item.queue_free()
		current_item = null

	if inventory.is_empty():
		return

	var selected_item_scene: PackedScene = preload("res://common/components/Inventory/InventoryItem.tscn")
	current_item = selected_item_scene.instantiate()
	current_item.item_resource = inventory.front()
	current_item.scale = inventory_spawn_scale
	inventory_spawn.add_child(current_item)

func has_item_of_type(type: Item.ItemType)->bool:
	for i in range(inventory.size()):
		if inventory[i].type == type:
			return true
	return false
