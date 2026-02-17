extends State
class_name Idle

@export var player: Player
@onready var animation_player : AnimationPlayer = %AnimationPlayer

func enter()->void:
	animation_player.play("idle")
	
func physics_update(_delta: float)-> void:
	if Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("up") or Input.is_action_pressed("down"):
		transition.emit(self, "Walk")
	else:
		player.velocity_component.set_horizontal(0)

func process_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("up"):
		transition.emit(self, "Jump")
