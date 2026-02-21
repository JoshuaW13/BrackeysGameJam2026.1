extends CharacterBody2D
class_name NPC

@export var npc : NPCResource
@onready var sprite : Sprite2D = $Sprite2D
@onready var interact_area : Area2D = $InteractArea2D
signal npc_dialogue(npc_id, name, dialogue_lines)
signal npc_completed(npc_id : String)
signal unlock(item_id: String)
var player
var in_dialogue : bool = false
var is_in_area : bool = false

func _ready():
	sprite.texture = npc.texture
	player = get_tree().get_nodes_in_group("player")
	interact_area.body_entered.connect(_on_body_entered)
	interact_area.body_exited.connect(_on_body_exited)

func _input(event):
	if event.is_action_pressed("interact") and is_in_area and not in_dialogue:
		interact()

func force_interact()->void:
	is_in_area = true
	var cancel_event = InputEventAction.new()
	cancel_event.action = "interact"
	cancel_event.pressed = true
	Input.parse_input_event(cancel_event)

func interact():
	if npc.dialogues.is_empty():
		return
	var event = npc.dialogues[npc.dialogue_index]
	if !event.condition or event.condition.is_met([ player[0],self], []):
		if event.pass_functions:
			perform_events(event.pass_functions)
		if event.pass_dialogues:
			perform_dialogue(event.pass_dialogues)
	else:
		if event.fail_functions:
			perform_events(event.fail_functions)
		if event.fail_dialogues:
			perform_dialogue(event.fail_dialogues)

func perform_events(actions : Array[Array]):
	for action in actions:
		if action.size() > 1:
			action[0].execute([self, player[0]], action[1])
		else:
			action[0].execute([self, player[0]])

func perform_dialogue(lines : Array[String]):
	in_dialogue = true
	emit_signal("npc_dialogue", npc.npc_id, npc.npc_name, lines)

func next():
	npc.dialogue_index += 1
	
func complete():
	print("Emitting npc completed")
	emit_signal("npc_completed", npc.npc_id)

func _on_finished_dialogue(npc_id):
	if npc.npc_id == npc_id:
		in_dialogue = false
		
func unlock_item(item_id):
	emit_signal("unlock", item_id)
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		is_in_area = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		is_in_area = false
