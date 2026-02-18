extends Panel

@onready var dialogue: Label = $TextLabel
signal dialogue_finished

var dialogue_lines: Array = []
var current_line: int = 0
var is_active: bool = false

func show_dialogue(lines: Array) -> void:
	if lines.is_empty():
		return

	if not is_active:
		dialogue_lines = lines
		current_line = 0
		is_active = true

		dialogue.text = dialogue_lines[current_line]
		visible = true
	
func _input(event):
	if not visible:
		return

	if event.is_action_pressed("interact"):
		current_line += 1
		if current_line < dialogue_lines.size():
			dialogue.text = dialogue_lines[current_line]
		else:
			end_dialogue()

func end_dialogue() -> void:
	visible = false
	is_active = false
	dialogue.text = ""
	emit_signal("dialogue_finished")

	
