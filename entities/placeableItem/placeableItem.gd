extends RigidBody2D
class_name PlaceableItem

var inventory_item : Resource
@onready var sprite = %Sprite2D

func _ready() -> void:
	if inventory_item is Item:
		sprite.texture = inventory_item.texture

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action("take"):
		SignalBus.item_picked_up.emit(self)
