extends State
class_name FreeFall

@export var player: Player
@onready var animation_player : AnimationPlayer = %AnimationPlayer

func enter()->void:
	animation_player.play("freefall")
	
func physics_update(_delta: float)-> void:
	if player.is_on_floor():
		transition.emit(self,"Idle")	
