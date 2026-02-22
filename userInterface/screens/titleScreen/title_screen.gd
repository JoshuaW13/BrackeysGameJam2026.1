extends Control

var MAIN_MENU_THEME = load("res://audio/music/main.ogg")
var BUTTON_SOUND = load("res://audio/menubutton.wav")

func _ready() -> void:
	GlobalAudio.play_music(MAIN_MENU_THEME)

func _on_play_button_down() -> void:
	GlobalAudio.play_menu_fx(BUTTON_SOUND)
	#get_tree().change_scene_to_file("res://userInterface/screens/intro/Intro.tscn")
	get_tree().change_scene_to_file("res://userInterface/screens/finalCutscene/FinalCutscene.tscn")
	
