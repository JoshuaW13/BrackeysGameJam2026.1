extends RigidBody2D
class_name PlaceableItem

@export var inventory_item: Item
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite.texture = inventory_item.texture

func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action("take"):
		if check_los():
			SignalBus.item_picked_up.emit(self)

func check_los():
	var player = get_tree().get_first_node_in_group("player")
	if player.global_position.distance_to(global_position) > 30:
		print("Item too far")
		return false

	#var space_state = get_world_2d().direct_space_state

	#var raycast = PhysicsRayQueryParameters2D.create(self.global_position, player.global_position)
	#var raycast_result = space_state.intersect_ray(raycast)
	#if !raycast_result.is_empty():
		#print("blocked")
		#return false

	return true
