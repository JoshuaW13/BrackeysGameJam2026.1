extends Control

const BUTTON_SOUND = preload("res://audio/menubutton.wav")

func _on_play_button_down() -> void:
	GlobalAudio.play_menu_fx(BUTTON_SOUND)
	get_tree().change_scene_to_file("res://userInterface/screens/intro/Intro.tscn")
