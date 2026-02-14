extends FlipComponent
class_name FlipOnMouseComponent

func _process(_delta: float) -> void:
	if patient and flip_allowed and is_multiplayer_authority():
		var direction: Vector2 = get_global_mouse_position() - patient.global_position
		
		if direction.x < 0 and facing == Facing.RIGHT:
			facing = Facing.LEFT
			patient.scale.x = -1
			scale_changed.emit()
		
		elif direction.x > 0 and facing == Facing.LEFT:
			facing = Facing.RIGHT
			patient.scale.x = 1 
			scale_changed.emit()
