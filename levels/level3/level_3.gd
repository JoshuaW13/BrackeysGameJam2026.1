extends Node2D

@onready var dialogue_panel : DialoguePanel = $Player/DialoguePanel
var remaining_npcs := {}
var level_complete : bool = false

func _ready():
	for npc in get_tree().get_nodes_in_group("npc"):
		if npc is NPC:
			remaining_npcs[npc.npc_id] = true
			npc.npc_completed.connect(_on_npc_completed)
	dialogue_panel.dialogue_finished.connect(_on_finished_dialogue)
	
func _on_npc_completed(npc_id):
	remaining_npcs.erase(npc_id)

	if remaining_npcs.is_empty():
		level_complete = true

func _on_finished_dialogue(npc):
	print("Test")
	if level_complete:
		print("Level Complete!")
