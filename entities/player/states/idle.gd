extends State
class_name Idle

func enter()->void:
	print("Entering idle")

func physics_update(_delta: float)-> void:
	if Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("up") or Input.is_action_pressed("down"):
		transition.emit(self, "Walk")
