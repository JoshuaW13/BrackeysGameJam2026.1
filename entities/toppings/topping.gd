extends StaticBody2D
class_name Topping

@export var type: Coffee.Topping = Coffee.Topping.NONE

func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	print("Taking the toppping!")
	if event.is_action("take"):
		print("Take")
		if check_los():
			SignalBus.topping_picked_up.emit(self)

func check_los():
	var player = get_tree().get_first_node_in_group("player")
	if player.global_position.distance_to(global_position) > 30:
		print("Item too far")
		return false

	# Could not get line of sight working, tried it for fun. But did limit distance.
		
	return true
