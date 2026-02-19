extends Node2D

var remaining_npcs := {}

func _ready():
	for npc in get_tree().get_nodes_in_group("npc"):
		remaining_npcs[npc.npc_id] = true
		npc.npc_completed.connect(_on_npc_completed)

func _on_npc_completed(npc_id):
	remaining_npcs.erase(npc_id)
		
	if remaining_npcs.is_empty():
		level_completed()

func level_completed():
	print("Level Complete!")
