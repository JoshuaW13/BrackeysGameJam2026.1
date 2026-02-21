extends State
class_name Stunned

@onready var animation_player :AnimationPlayer = %AnimationPlayer

func enter()->void:
	animation_player.play("walk")
