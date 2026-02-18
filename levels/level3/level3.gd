extends Node2D

@onready var dialogue_panel:= $Player/DialoguePanel

func _ready() -> void:
	var npcs = get_tree().get_nodes_in_group("npc")
	for npc in npcs:
		npc.interacted.connect(_on_npc_interacted)
		
func _on_npc_interacted(npc_id: String) -> void:
	print("Signal from ", npc_id)

	if not npc_state.has(npc_id):
		npc_state[npc_id] = 0

	var event_index = npc_state[npc_id]

	if not event_database.has(npc_id):
		print("No events for NPC:", npc_id)
		return

	var npc_events = event_database[npc_id]

	if event_index >= npc_events.size():
		print("No more events for NPC:", npc_id)
		return

	var event = npc_events[event_index]
	
	match event[0]:
		"Dialogue":
			var dialogue_id = event[1]
			var lines = dialogue_database.get(dialogue_id, [])
			dialogue_panel.show_dialogue(lines)

			dialogue_panel.dialogue_finished.connect(
				func(): npc_state[npc_id] += 1
			)

var npc_state := {"Lv3Manager": 0, "Lv3Coworker": 0, "Lv3Senior": 0}

var event_database := {
	"Lv3Manager": [
		["Dialogue", "ManagerDismissal"],
	],
	"Lv3Coworker": [
		["Dialogue", "CoworkerHello"],
	],
	"Lv3Senior": [
		["Dialogue", "SeniorHint"],
	],
}
	
var dialogue_database := {
	"CoworkerHello": [
		"Hello fellow intern!",
		"Testing multiple NPC interactions.",
		"Now go bother the manager.",
	],
	"SeniorHint": [
		"Hey, pstt.",
		"We might have some boxes around to help you get over this wall.",
		"Good luck, I'm taking my lunch break.",
	],
	"ManagerDismissal": [
		"Bothering me again!",
		"Considering how good you are at somehow getting here. You'll do well in the lab.",
		"Go help them there, shoo",
	],
}
