extends PlaceableItem
class_name Box

func _ready() -> void:
	if inventory_item == null:
		inventory_item = load("res://entities/box/box.tres")
	super._ready()
