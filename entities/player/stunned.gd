extends State
class_name Stunned

@onready var animation_player :AnimationPlayer = %AnimationPlayer

func enter()->void:
	print("Entering stunned state!")
	animation_player.play("walk")
