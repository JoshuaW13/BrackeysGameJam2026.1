extends Node2D
class_name Door

@export var door : DoorResource
@onready var sprite : Sprite2D = $Sprite2D
@onready var lock : Sprite2D = $Lock
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var timer : Timer = $OpenTimer
signal npc_dialogue

var is_in_area: String = ""

func _ready():
	var npcs = get_tree().get_nodes_in_group("npc")
	for npc in npcs:
		if npc is NPC:
			npc.unlock.connect(_on_unlock_door)
		if npc is Button2D:
			npc.unlock.connect(_on_unlock_door)
			npc.lock.connect(_on_lock_door)
			
	if door.is_locked:
		lock.visible = true
	else:
		lock.visible = false

func _input(event):
	if event.is_action_pressed("interact") and is_in_area != "":
		interact()
		
func interact():
	if door.is_locked:
		print("Test")
		emit_signal("npc_dialogue", "message", "", ["The door is locked"])
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
		lock.visible = false

func _on_lock_door(door_id):
	print("Recieved lock_door signal: ", door_id)
	if door.door_id == door_id:
		door.is_locked = true
		lock.visible = true
