extends Node2D

@export var elevator : ElevatorResource
@onready var animation : AnimationPlayer = $AnimationPlayer

var is_in_area : bool = false

func _ready():
	animation.animation_finished.connect(_on_animation_finished)

func _input(event):
	if event.is_action_pressed("interact") and is_in_area:
		interact()
		
func interact():
	animation.play("open")
	
func _on_animation_finished(animation_name):
	if animation_name == "open":
		get_tree().change_scene_to_packed(elevator.scene)

func _on_body_entered(body):
	is_in_area = true

func _on_body_exited(body):
	is_in_area = false
