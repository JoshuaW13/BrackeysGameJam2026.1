extends State
class_name Walk

@export var player: Player
var last_direction := Vector2.ZERO

func enter()->void:
	print("Entering walk")

func determine_direction() -> Vector2:
	var left  = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	var up    = Input.is_action_pressed("up")
	var down  = Input.is_action_pressed("down")
	
	var direction = Vector2.ZERO
	if left and not right:
		direction.x = -1
		last_direction.x = -1
	elif right and not left:
		direction.x = 1
		last_direction.x = 1
	elif left and right:
		direction.x = last_direction.x
	else:
		last_direction.x = 0

	return direction

func physics_update(delta: float) -> void:
	var direction = determine_direction()

	if direction == Vector2.ZERO:
		transition.emit(self, "Idle")
		player.velocity_component.set_horizontal(0)
		return

	player.velocity_component.set_horizontal(direction.x)
