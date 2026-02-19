extends Node
class_name Npc

var resource : NpcResource

var current_dialogue: int =0
var is_talking: bool = false

func on_input():
	pass
	# if dialogue is not empty and is not talking
	# does condition for current dialogue pass if it exists
	# if it passes or does not exist display pass dialogue, trigger pass action and increment dialogue index
	# else fail dialogue and action
