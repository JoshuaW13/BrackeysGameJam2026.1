extends Node2D

@onready var dialogue_panel : DialoguePanel = $Player/DialoguePanel
@onready var player : Player = $Player

func _ready() -> void:
	var npcs = get_tree().get_nodes_in_group("npc")

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
