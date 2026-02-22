extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var skip_button : Button = $SkipButton

var FINAL_LEVEL_THEME = load("res://audio/music/levels_1.ogg")

func _ready() -> void:
	GlobalAudio.play_music(FINAL_LEVEL_THEME)
	animation_player.play("credits")

func _animation_finished() -> void:
	_load_title_screen()

func _load_title_screen() -> void:
	get_tree().change_scene_to_file("res://userInterface/screens/titleScreen/TitleScreen.tscn")
