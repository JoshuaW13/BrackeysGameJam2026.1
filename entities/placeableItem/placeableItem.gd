extends RigidBody2D
class_name PlaceableItem

var inventory_item: Item
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite.texture = inventory_item.texture

func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action("take"):
		SignalBus.item_picked_up.emit(self)
