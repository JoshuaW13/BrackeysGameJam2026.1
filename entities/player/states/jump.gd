extends State
class_name Jump

@export var player: Player

var jump_vertical_speed: float = 1300
var jump_horizontal_speed: float = 1

func enter()->void:
	var x_dir = 0
	if Input.is_action_pressed("left"):
		x_dir = -1
	elif Input.is_action_pressed("right"):
		x_dir = 1
	player.velocity_component.set_vertical(-jump_vertical_speed)
	player.velocity_component.set_horizontal(x_dir)

func physics_update(_delta: float)-> void:
	if player.is_on_floor():
		transition.emit(self,"Idle")
