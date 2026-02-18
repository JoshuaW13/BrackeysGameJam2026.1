extends Node2D

var is_locked: bool = false
var is_in_area: String = ""
@onready var door: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $OpenTimer

func _input(event):
	if event.is_action_pressed("interact") and is_in_area != "":
		print("TEST")
		interact()
		
func interact():
	timer.start()
	if is_in_area == "left":
		door.flip_h = false
	elif is_in_area == "right":
		door.flip_h = true
	animation.play("open")
	
func _on_open_timer_timeout() -> void:
	animation.play_backwards("open")
	
func _on_left_body_entered(body):
	if body.is_in_group("player"):
		is_in_area = "left"

func _on_left_body_exited(body):
	if body.is_in_group("player"):
		is_in_area = ""
		
func _on_right_body_entered(body):
	if body.is_in_group("player"):
		is_in_area = "right"

func _on_right_body_exited(body):
	if body.is_in_group("player"):
		is_in_area = ""
