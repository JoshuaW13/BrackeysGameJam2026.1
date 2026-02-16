extends State
class_name Jump

@export var player: Player

var jump_vertical_speed: float = 1100

func enter()->void:
	player.velocity_component.set_vertical(-jump_vertical_speed)

func physics_update(_delta: float)-> void:
	if player.is_on_floor():
		transition.emit(self,"Idle")
