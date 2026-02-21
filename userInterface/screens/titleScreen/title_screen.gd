extends Control

const MAIN_MENU_THEME = preload("res://audio/music/main.ogg")
const BUTTON_SOUND = preload("res://audio/menubutton.wav")

func _ready() -> void:
	GlobalAudio.play_music(MAIN_MENU_THEME)

func _on_play_button_down() -> void:
	GlobalAudio.play_menu_fx(BUTTON_SOUND)
	get_tree().change_scene_to_file("res://userInterface/screens/intro/Intro.tscn")
