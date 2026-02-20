extends Node2D

@export var elevator : ElevatorResource
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var interact_area : Area2D = $InteractArea2D

var is_in_area : bool = false

func _ready():
	animation.animation_finished.connect(_on_animation_finished)
	interact_area.body_entered.connect(_on_body_entered)
	interact_area.body_exited.connect(_on_body_exited)

func _input(event):
	if event.is_action_pressed("interact") and is_in_area:
		interact()
		
func interact():
	animation.play("open")
	
func _on_animation_finished(animation_name):
	if animation_name == "open":
		get_tree().change_scene_to_file(elevator.scene_path)

func _on_body_entered(body):
	is_in_area = true

func _on_body_exited(body):
	is_in_area = false
