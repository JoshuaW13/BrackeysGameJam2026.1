extends Node

var BUTTON_SOUND = load("res://audio/menubutton.wav")

func _ready() -> void:
	self.pressed.connect(_play_sound)

func _play_sound() -> void:
	GlobalAudio.play_menu_fx(BUTTON_SOUND)
