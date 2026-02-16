extends PlaceableItem
class_name Box

func _ready() -> void:
	inventory_item = preload("res://entities/box/box.tres")
	super._ready()
