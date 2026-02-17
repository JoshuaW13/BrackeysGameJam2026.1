extends CharacterBody2D

@onready var interact:= $InteractArea2D
var is_in_area: bool = false

func _ready():
	$InteractArea2D.body_entered.connect(_on_body_entered)
	
func _input(event):
	if event.is_action_pressed("interact") and is_in_area:
		print("Do something!")

func _on_body_entered(body):
	if body.is_in_group("player"):
		is_in_area = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		is_in_area = false
