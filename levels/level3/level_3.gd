extends Node2D

@export var level_resource : LevelResource
@onready var player : Player = $Player
@onready var dialogue_panel : DialoguePanel = $Player/Camera2D/DialoguePanel
signal npc_dialogue(id, type, dialogue_lines)
var BOX_RES = load("res://entities/box/box.tres")
var COFFEE_RES = load("res://entities/coffee/coffee.tres")
var remaining_npcs := {}
var level_complete : bool = false
var LEVEL_1_THEME = load("res://audio/music/levels_1.ogg")

func _ready():
	GlobalAudio.play_music(LEVEL_1_THEME)
	for npc in get_tree().get_nodes_in_group("npc"):
		if npc is NPC:
			if !npc.npc.completed:
				remaining_npcs[npc.npc.npc_id] = true
				npc.npc_completed.connect(_on_npc_completed)
	dialogue_panel.dialogue_finished.connect(_on_finished_dialogue)
	
	for i in range(3):
		var new_item : Item = BOX_RES.duplicate(true)
		new_item.id = player.player_resource.item_id
		player.player_resource.item_id += 1
		player.inventory.add_item(new_item)
	
func _on_npc_completed(npc_id):
	remaining_npcs.erase(npc_id)

	if remaining_npcs.is_empty():
		level_complete = true

func _on_finished_dialogue(npc):
	if level_complete:
		emit_signal("npc_dialogue", "message", "Level Complete!")
		GameData.mark_completed(get_tree().current_scene.name)
