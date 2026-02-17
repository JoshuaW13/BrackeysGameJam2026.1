extends PlaceableItem
class_name Coffee

func _ready() -> void:
	inventory_item = load("res://entities/coffee/coffee.tres")
	super._ready()
