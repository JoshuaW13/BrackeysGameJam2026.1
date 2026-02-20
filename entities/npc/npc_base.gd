extends CharacterBody2D
class_name NPC

@export var npc : NPCResource
@onready var sprite : Sprite2D = $Sprite2D
signal npc_dialogue(npc_id, dialogue_lines)
signal npc_completed(npc_id : String)
signal unlock_door(door_id: String)
var player
var npc_id : String = ""
var in_dialogue : bool = false
var is_in_area : bool = false

func _ready():
	npc_id = npc.npc_id
	sprite.texture = npc.texture
	player = get_tree().get_nodes_in_group("player")

func _input(event):
	if event.is_action_pressed("interact") and is_in_area and not in_dialogue:
		interact()

func interact():
	var event = npc.dialogues[npc.dialogue_index]
	if !event.condition or event.condition.is_met(player):
		if event.pass_functions:
			perform_events(event.pass_functions)
		perform_dialogue(event.pass_dialogues)
	else:
		if event.fail_functions:
			perform_events(event.fail_functions)
		perform_dialogue(event.fail_dialogues)

func perform_events(actions : Array[Array]):
	for action in actions:
		action[0].execute([self], action[1])
	
func perform_dialogue(lines : Array[String]):
	in_dialogue = true
	emit_signal("npc_dialogue", npc_id, lines)

func complete():
	emit_signal("npc_completed", npc_id)

func _on_finished_dialogue(npc):
	if self.npc_id == npc:
		in_dialogue = false
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		is_in_area = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		is_in_area = false
