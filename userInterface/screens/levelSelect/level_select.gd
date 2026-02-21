extends Control

@export var levels: Array[PackedScene] = []
@onready var level_selection_grid: GridContainer =%GridContainer

const BUTTON_SOUND = preload("res://audio/menubutton.wav")

func _ready() -> void:
	for i in range(levels.size()+1):
		var elevator_button_scene : PackedScene = load("res://userInterface/components/elevatorButton/ElevatorButton.tscn")
		var elevator_button : ElevatorButton= elevator_button_scene.instantiate()
		if i==0:
			elevator_button.text = str("M")
		else:
			elevator_button.text = str(i)
		level_selection_grid.add_child(elevator_button)
		if i ==0:
			elevator_button.button.button_down.connect(func():
				GlobalAudio.play_menu_fx(BUTTON_SOUND)
				get_tree().change_scene_to_file("res://userInterface/screens/titleScreen/TitleScreen.tscn")
			)
		else:
			elevator_button.button.button_down.connect(func():
				GlobalAudio.play_menu_fx(BUTTON_SOUND)
				get_tree().change_scene_to_packed(levels[i-1])
			)
