extends Node
class_name Inventory

@export var inventory_spawn: Marker2D
@export var inventory_spawn_scale: Vector2 = Vector2(1, 1)
var inventory: Array[Item] = []
var extra_toppings: Array[Coffee.Topping] = []
var current_item: InventoryItem
var COFFEE_RES = load("res://entities/coffee/coffee.tres")
var BOX_RES = load("res://entities/box/box.tres")
var next_item_id : int= 0

func _ready() -> void:
	pass
	#for i in range(3):
		#var new_item : Item = BOX_RES.duplicate(true)
		#new_item.id = next_item_id
		#next_item_id += 1
		#add_item(new_item)
	#for i in range(3):
		#var new_item : Item
		#if i%2==0:
			#new_item = COFFEE_RES.duplicate(true)
		#else:
			#new_item  = BOX_RES.duplicate(true)
		#new_item.id = next_item_id
		#next_item_id += 1
		#add_item(new_item)

func add_item(item: Item)->void:
	if item.type == Item.ItemType.COFFEE and !extra_toppings.is_empty():
		item.topping = extra_toppings.pop_front()
	inventory.push_back(item)
	if inventory.size() == 1:
		spawn_front()

func remove_item()->void:
	if inventory.is_empty():
		return
	inventory.pop_front()
	spawn_front()

func use_item()->bool:
	if inventory.is_empty():
		return false
	var selected_item : Item = inventory.front()
	var item_instance : PlaceableItem = selected_item.scene.instantiate()
	item_instance.position = inventory_spawn.global_position
	item_instance.inventory_item = selected_item
	get_tree().current_scene.add_child(item_instance)
	if item_instance is Coffee :
		item_instance.topping = selected_item.topping
	remove_item()
	return true

func cycle_right()->void:
	if inventory.is_empty(): return
	var first_item: Item = inventory.pop_front()
	inventory.append(first_item)
	spawn_front()

func cycle_left()->void:
	if inventory.is_empty(): return
	var first_item: Item = inventory.pop_back()
	inventory.push_front(first_item)
	spawn_front()

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
	
func holding_item_of_type(type: Item.ItemType, topping: Coffee.Topping = Coffee.Topping.NONE)->bool:
	if inventory.is_empty():
		return false
	if current_item.item_resource.type == type and current_item.item_resource.topping == topping:
		inventory.pop_front()
		current_item.queue_free()
		current_item = null
		return true
	return false

func add_topping(topping: Topping)->void:
	for i in range(inventory.size()):
		var inventory_item = inventory[i]
		if inventory_item.type==Item.ItemType.COFFEE and inventory_item.topping == Coffee.Topping.NONE:
			print("topping.type raw: ", topping.type)
			print("inventory_item.topping raw: ", inventory_item.topping)
			print("Setting topping type to "+str(topping.type))
			inventory_item.topping = topping.type
			print("topping type is  "+str(inventory_item.topping))
			spawn_front()
			return
	extra_toppings.append(topping.type)
