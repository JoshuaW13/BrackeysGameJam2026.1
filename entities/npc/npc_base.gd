extends CharacterBody2D

@export var npc_id : String
signal interacted(dialogue_lines)
var is_in_area: bool = false

func _input(event):
	if event.is_action_pressed("interact") and is_in_area:
		interact()
		
func interact():
	emit_signal("interacted", npc_id)

func _on_body_entered(body):
	if body.is_in_group("player"):
		is_in_area = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		is_in_area = false
