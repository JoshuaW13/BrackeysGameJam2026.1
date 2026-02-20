extends Node2D

@export var door : DoorResource
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var timer : Timer = $OpenTimer

var is_in_area: String = ""

func _ready():
	var npcs = get_tree().get_nodes_in_group("npc")
	for npc in npcs:
		if npc is NPC:
			npc.unlock.connect(_on_unlock_door)

func _input(event):
	if event.is_action_pressed("interact") and is_in_area != "":
		interact()
		
func interact():
	if not door.is_locked and timer.is_stopped():
		timer.start()
		if is_in_area == "left":
			sprite.flip_h = false
		elif is_in_area == "right":
			sprite.flip_h = true
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
		
func _on_unlock_door(door_id):
	print("Recieved unlock_door signal: ", door_id)
	if door.door_id == door_id:
		door.is_locked = false
