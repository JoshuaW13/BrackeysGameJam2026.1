extends Control

@export var levels: Array[PackedScene] = []
@onready var level_selection_grid: GridContainer = %GridContainer

func _ready() -> void:
	for i in range(levels.size()):
		var button : Button = Button.new()
		button.text = str(i+1)
		button.button_down.connect(func():
			get_tree().change_scene_to_packed(levels[i])
			)
		level_selection_grid.add_child(button)


func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://userInterface/screens/titleScreen/TitleScreen.tscn")
