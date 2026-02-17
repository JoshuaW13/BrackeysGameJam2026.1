extends State
class_name Jump

@onready var animation_player : AnimationPlayer = %AnimationPlayer
@export var player: Player

var jump_vertical_speed: float = 500
var last_direction := Vector2.ZERO
const JUMP_HORIZONTAL_SPEED = 30

func enter()->void:
	animation_player.play("jump")
	player.velocity_component.set_vertical(-jump_vertical_speed)
	player.velocity_component.speed = JUMP_HORIZONTAL_SPEED

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
