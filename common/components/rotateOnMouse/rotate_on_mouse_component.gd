extends Node2D
class_name RotateOnMouseComponent

@export var patient: Node2D
@export var flipper: FlipComponent

var rotate_allowed: bool = true

func clamp_flipped_angle(angle:float)->float:
	const UPPER_BOUND = 135
	const LOWER_BOUND = -135
	if LOWER_BOUND < angle && angle <0:
		return LOWER_BOUND
	elif UPPER_BOUND > angle && angle >=0:
		return UPPER_BOUND
	return angle

func _process(_delta: float) -> void:
	if not patient or !is_multiplayer_authority() or !rotate_allowed:
		return
	var mouse_pos: Vector2 = get_global_mouse_position()
	var to_mouse: Vector2 = mouse_pos - patient.global_position
	var angle: float = rad_to_deg(to_mouse.angle())
	if flipper and flipper.facing == flipper.Facing.LEFT:
		patient.rotation_degrees = 180-clamp_flipped_angle(angle)
	else:
		var clamped_angle = clamp(angle, -45, 45)
		patient.rotation_degrees = clamped_angle
