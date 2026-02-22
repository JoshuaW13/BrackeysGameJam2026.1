extends Control
class_name DialoguePanel

@onready var panel : Control = self
@onready var sprite : Sprite2D = $Sprite2D
@onready var dialogue: Label = %TextLabel
@onready var name_label : Label = %NameLabel
@onready var dialogue_sprite : Texture = load("res://entities/dialogue/DialoguePanel.png")
@onready var message_sprite : Texture = load("res://entities/dialogue/MessageBox.png")
signal dialogue_finished(npc_id)

var dialogue_lines: Array = []
var current_line: int = 0
var ignore_next_input := false
var npc : String

func _ready() -> void:
	var npcs = get_tree().get_nodes_in_group("npc")
	for npc in npcs:
		if npc is NPC:
			panel.dialogue_finished.connect(npc._on_finished_dialogue)
			npc.npc_dialogue.connect(_on_npc_dialogue)
		if npc is Door:
			npc.npc_dialogue.connect(_on_npc_dialogue)
			
func _on_npc_dialogue(npc_id, name, lines):
	npc = npc_id
	
	if npc_id == "message":
		#sprite.texture = message_sprite
		name_label.text = ""
	else:
		#sprite.texture = dialogue_sprite
		name_label.text = name
	
	if lines.is_empty():
		return

	if not visible:
		dialogue_lines = lines
		current_line = 0
		ignore_next_input = true
		#set_movement(false)
		
		dialogue.text = dialogue_lines[current_line]
		_play_sfx(dialogue.text.length())

		visible = true
	
func _input(event):
	if event.is_action_pressed("interact") and not visible:
		return

	if event.is_action_pressed("interact"):
		if ignore_next_input:
			ignore_next_input = false
			return

		current_line += 1
		
		if current_line < dialogue_lines.size():
			dialogue.text = dialogue_lines[current_line]
			_play_sfx(dialogue.text.length())
		else:
			end_dialogue()
			
func _play_sfx(text_length: int):
	if npc != "message":
		GlobalAudio.play_dialogue_fx(text_length / 4)

func end_dialogue() -> void:
	visible = false
	#set_movement(true)
	dialogue.text = ""
	emit_signal("dialogue_finished", npc)
	
func set_movement(state):
	return
	var players = get_tree().get_nodes_in_group("player")
	for player in players:
		if player is Player:
			player.can_move = state
