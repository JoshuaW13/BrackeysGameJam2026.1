extends Node2D

signal lock_door(door_id: String)
signal unlock_door(door_id: String)
@onready var dialogue_panel : DialoguePanel = $Player/DialoguePanel
@onready var player : Player = $Player
var npc_id_2

func _ready() -> void:
	var npcs = get_tree().get_nodes_in_group("npc")
	for npc in npcs:
		npc.interacted.connect(_on_npc_interacted)
		
func _on_npc_interacted(npc_id: String) -> void:
	npc_id_2 = npc_id

	if not npc_state.has(npc_id):
		push_error("NPC id does not exist")

	var event_index = npc_state[npc_id]

	if not event_database.has(npc_id):
		push_error("No events for NPC:", npc_id)
		return

	var npc_events = event_database[npc_id]

	if event_index >= npc_events.size():
		print("No more events for NPC:", npc_id)
		return

	var event = npc_events[event_index]
	var dialogue_id = event[1]
	
	match event[0]:
		"Dialogue":
			var lines = dialogue_database.get(dialogue_id, [])
			dialogue_panel.show_dialogue(lines)
		"ConditionalDialogue":
			var passCheck = false
			var dialogueOptions = dialogue_database.get(dialogue_id, [])
			match event[2]:
				"HasCoffee":
					passCheck = has_coffee()
					emit_signal("unlock_door", "Lv3Door")
			if passCheck:
				var lines = dialogueOptions[0]
				dialogue_panel.show_dialogue(lines)

				if not dialogue_panel.dialogue_finished.is_connected(add):
					dialogue_panel.dialogue_finished.connect(add)
			else:
				var lines = dialogueOptions[1]
				dialogue_panel.show_dialogue(lines)	
				
	print("End")
			
func add(): 
	npc_state[npc_id_2] += 1
	print(self) 
	
func has_coffee():
	return player.inventory.has_item_of_type(Item.ItemType.COFEE)

var npc_state := {"Lv3Manager": 0, "Lv3Coworker": 0, "Lv3Senior": 0}

var event_database := {
	"Lv3Manager": [
		["ConditionalDialogue", "ManagerCoffee", "HasCoffee"],
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
	"ManagerCoffee": [
		[
			"That's some good coffee",
			"That's some good coffeeeeeeeeeeeeeeeeeeeeeee"
		],
		[
			"Where is my coffee"
		]
	],
}
