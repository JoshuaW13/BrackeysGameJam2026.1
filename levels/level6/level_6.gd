extends Node2D

@onready var player : Player = $Player
var BOX_RES = load("res://entities/box/box.tres")
var COFFEE_RES = load("res://entities/coffee/coffee.tres")
var level_complete : bool = false
var next_item_id : int= 0
var LEVEL_4_THEME = load("res://audio/music/levels_4.ogg")

func add_starting_items()->void:
	for i in range(5):
		var new_item : Item
		if i == 0:
			new_item = COFFEE_RES.duplicate(true)
		else:
			new_item = BOX_RES.duplicate(true)
		new_item.id = next_item_id
		next_item_id += 1
		player.inventory.add_item(new_item)

func _ready():
	GlobalAudio.play_music(LEVEL_4_THEME)
	add_starting_items()
	for npc in get_tree().get_nodes_in_group("npc"):
		if npc is NPC:
			if !npc.npc.completed:
				print("Connecting npc completed")
				npc.npc_completed.connect(_on_npc_completed)
	player.dialogue_panel.dialogue_finished.connect(_on_finished_dialogue)

func _on_npc_completed(npc_id: String)->void:
	GameData.mark_completed(get_tree().current_scene.name)

func _on_finished_dialogue(npc):
	if level_complete:
		GameData.mark_completed(get_tree().current_scene.name)
		get_tree().change_scene_to_file("res://levels/intro/Intro.tscn")
