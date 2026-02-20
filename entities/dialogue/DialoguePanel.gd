extends Panel
class_name DialoguePanel

@onready var panel : Control = self
@onready var dialogue: Label = $TextLabel
signal dialogue_finished(npc_id)

var dialogue_lines: Array = []
var current_line: int = 0
var is_active: bool = false
var npc : String

func _ready() -> void:
	var npcs = get_tree().get_nodes_in_group("npc")

	for npc in npcs:
		if npc is NPC:
			panel.dialogue_finished.connect(npc._on_finished_dialogue)
			npc.npc_dialogue.connect(_on_npc_dialogue)

func _on_npc_dialogue(npc_id, lines):
	npc = npc_id
	if lines.is_empty():
		return

	if not is_active:
		dialogue_lines = lines
		current_line = -1
		is_active = true

		dialogue.text = dialogue_lines[current_line]
		visible = true
	
func _input(event):
	if not visible:
		return

	if event.is_action_pressed("interact"):
		current_line += 1
		if current_line < dialogue_lines.size():
			dialogue.text = dialogue_lines[current_line]
		else:
			end_dialogue()

func end_dialogue() -> void:
	visible = false
	is_active = false
	dialogue.text = ""
	emit_signal("dialogue_finished", npc)
