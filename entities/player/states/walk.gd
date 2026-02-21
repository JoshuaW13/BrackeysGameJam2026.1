extends State
class_name Walk

@onready var animation_player : AnimationPlayer = %AnimationPlayer

@export var player: Player
var last_direction := Vector2.ZERO
const WALK_SPEED = 100.0

func enter()->void:
	animation_player.play("walk")
	player.velocity_component.speed = WALK_SPEED

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
	
func play_footstep():
	if player.walkSoundTimer.is_stopped():
		player.walkSoundPlayer.play()
		player.walkSoundTimer.start()

func physics_update(_delta: float) -> void:
	var direction: Vector2 = determine_direction()
	
	if !player.is_on_floor():
		transition.emit(self, "FreeFall")
	elif direction == Vector2.ZERO:
		transition.emit(self, "Idle")
		player.velocity_component.set_horizontal(0)
		return
	else:
		play_footstep()

	player.velocity_component.set_horizontal(direction.x)

func process_input(_event: InputEvent)-> void:
	if _event.is_action_pressed("up"):
		transition.emit(self, "Jump")
