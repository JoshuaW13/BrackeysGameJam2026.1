extends CharacterBody2D

@export var npc : NPCResource
@onready var sprite : Sprite2D = $Sprite2D
signal npc_dialogue(npc_id, dialogue_lines)
signal unlock_door(door_id: String)
var npc_id : String = ""
var in_dialogue : bool = false
var is_in_area : bool = false

func _ready():
	npc_id = npc.npc_id
	sprite.texture = npc.texture

func _input(event):
	if event.is_action_pressed("interact") and is_in_area and not in_dialogue:
		interact()
		
func interact():
	var event = npc.events[npc.event_state]
	if event_check(event[0]):
		perform_events(event[1])
	else:
		perform_events(event[2])
	var lines = npc.dialogue[npc.dialogue_state]
	in_dialogue = true
	emit_signal("npc_dialogue", npc_id, lines)
		
func _on_finished_dialogue():
	if npc_id == npc_id:
		in_dialogue = false

func event_check(event_id : String):
	match event_id:
		"":
			return true
		"has_coffee":
			# Dunno how to implement check from here
			return false

func perform_events(event_list : String):
	var events = parse_events(event_list)
	for event in events:
		print("Testing: ", event[0])
		match event[0]:
			"":
				pass
			"state":
				npc.dialogue_state = event[1]
				npc.event_state = event[2]
			"unlock_door":
				print("emitted unlock_door: ", event[1])
				emit_signal("unlock_door", event[1])

func parse_events(event_list : String):
	if event_list == "":
		return [[""]]
		
	var parsed_events = []
	var events = event_list.replace(" ", "").split(",")
	for event_string in events:
		var event_array : Array[String] = []
		print("Testing: ", event_string)
		if event_string.contains("("):
			print("Testing: Has parenthesis")
			var open_index = event_string.find("(")
			var close_index = event_string.find(")")
			print("Testing: ", event_string.substr(0, open_index))
			event_array.append(event_string.substr(0, open_index))
			var args_string = event_string.substr(
				open_index + 1,
				close_index - open_index - 1
			)
			var args = args_string.split("/")
			print("Testing: ", args)
			event_array.append_array(args)
			print("Testing: ", event_array)
		else:
			event_array.append(event_string)
		parsed_events.append(event_array)
	print("Testing: ", parsed_events)
	return parsed_events
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		is_in_area = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		is_in_area = false
