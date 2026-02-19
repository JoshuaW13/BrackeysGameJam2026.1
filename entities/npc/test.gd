extends Node
class_name npc

npc_resource : Resource
signal dialogue(string) # connect to the dialogue panel or level manager

func on_interact():
	#check if callable exists if it does run
	# if callable passes we emit signal with correct dialogue

class_name NpcResource

var dialogue_events : Array[NpcDialogue]

class_name NpcDialogue

var checkFunction : DialogueCondition
var passDialogue: Array[String]
var failDialogue: Array[String]

extend Resource
class_name DialogueCondition

func is_met(context)->bool:
	return true

extend DialogueCondition
class_name HasCoffee

func is_met(player)->bool:
	return player.inventory.has(coffee)
