extends Panel

@onready var dialogue = $TextLabel
var dialogue_lines : Array = [] 
var current_line : int = 0

func show_dialogue(dialogue_id: String) -> void:
	if not dialogue_database.has(dialogue_id):
		print("Dialogue ID not found:", dialogue_id)
		return

	if not visible:
		dialogue_lines = dialogue_database[dialogue_id]
		current_line = 0
		dialogue.text = dialogue_lines[current_line]
		visible = true
	else:
		current_line += 1
		if current_line < dialogue_lines.size():
			dialogue.text = dialogue_lines[current_line]
		else:
			hide_dialogue()

func hide_dialogue() -> void:
	visible = false
	
var dialogue_database := {
	"Lv2Manager": [
		"Hello unpaid intern.",
		"What? I don't need no box. Why are you bringing trash in here.",
        "Get out of here, I'm busy."
	],
}
	
