extends Node2D
class_name InventoryItem

var item_resource: Item
@onready var sprite: Sprite2D = %Sprite2D

func _ready():
	if item_resource:
		sprite.texture = item_resource.texture
