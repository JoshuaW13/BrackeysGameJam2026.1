extends State
class_name FreeFall

@export var player: Player
@onready var animation_player : AnimationPlayer = %AnimationPlayer

var last_direction := Vector2.ZERO

func enter()->void:
	animation_player.play("freefall")
	
func physics_update(_delta: float)-> void:
	var direction: Vector2 = determine_direction()
	if player.is_on_floor():
		transition.emit(self,"Idle")
	player.velocity_component.set_horizontal(direction.x)

func determine_direction() -> Vector2:
	var left  = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	
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
	
