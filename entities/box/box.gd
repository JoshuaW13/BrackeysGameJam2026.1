extends RigidBody2D
class_name Box

var box_item : Resource = preload("res://entities/box/box.tres")
@onready var sprite = %Sprite2D

func _ready() -> void:
	if box_item is Item:
		sprite.texture = box_item.texture

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action("take"):
		SignalBus.item_picked_up.emit(self)
