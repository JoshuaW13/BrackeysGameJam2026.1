extends CharacterBody2D

@export var npc : NPCResource
@onready var sprite : Sprite2D = $Sprite2D
signal npc_dialogue(npc_id, dialogue_lines)
signal unlock_door(door_id: String)
var npc_id : String = ""
var in_dialogue : bool = false
var is_in_area : bool = false

func _ready():
	npc_id = npc.npc_id
	sprite.texture = npc.texture

func _input(event):
	if event.is_action_pressed("interact") and is_in_area and not in_dialogue:
		interact()

func interact():
	var event = npc.dialogues[npc.dialogue_index]
	if event.condition.is_met():
		perform_events(event.pass_action)
		perform_dialogue(event.pass_dialogue)
	else:
		perform_events(event.fail_action)
		perform_dialogue(event.fail_dialogue)

func perform_events(actions : Array[Array]):
	for action in actions:
		action[0].execute(action[1])
	
func perform_dialogue(lines : Array[String]):
	in_dialogue = true
	emit_signal("npc_dialogue", npc_id, lines)

func _on_finished_dialogue():
		in_dialogue = false
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		is_in_area = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		is_in_area = false
