extends State
class_name FreeFall

@export var player: Player

func physics_update(_delta: float)-> void:
	if player.is_on_floor():
		transition.emit(self,"Idle")	
