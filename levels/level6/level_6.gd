extends Node2D

@onready var player : Player = $Player
var BOX_RES = load("res://entities/box/box.tres")
var COFFEE_RES = load("res://entities/coffee/coffee.tres")
var level_complete : bool = false

func _ready():
	for npc in get_tree().get_nodes_in_group("npc"):
		if npc is NPC:
			if !npc.npc.completed:
				print("Connecting npc completed")
				npc.npc_completed.connect(_on_npc_completed)
	player.dialogue_panel.dialogue_finished.connect(_on_finished_dialogue)
	
	var next_item_id : int = 0
	for i in range(2):
		var new_item : Item = BOX_RES.duplicate(true)
		new_item.type = 1
		new_item.id = next_item_id
		next_item_id += 1
		player.inventory.add_item(new_item)
	for i in range(1):
		var new_item : Item = COFFEE_RES.duplicate(true)
		new_item.type = 0
		new_item.id = next_item_id
		next_item_id += 1
		player.inventory.add_item(new_item)

func _on_npc_completed(npc_id: String)->void:
	print("Level complete!")

func _on_finished_dialogue(npc):
	if level_complete:
		GameData.mark_completed(get_tree().current_scene.name)
		get_tree().change_scene_to_file("res://levels/intro/Intro.tscn")
