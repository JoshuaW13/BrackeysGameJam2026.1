extends FlipComponent
class_name  FlipOnVelocity

@export var velocity_component: VelocityComponent

func _physics_process(delta: float) -> void:
	if patient and flip_allowed and velocity_component and is_multiplayer_authority():
		if velocity_component.velocity.x<0 and facing == Facing.RIGHT:
			facing = Facing.LEFT
			patient.scale.x = -1
			scale_changed.emit()
		
		elif velocity_component.velocity.x >0 and facing == Facing.LEFT:
			facing = Facing.RIGHT
			patient.scale.x = 1 
			scale_changed.emit()
