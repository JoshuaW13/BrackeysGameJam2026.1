extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer

var LEVEL_1_THEME = load("res://audio/music/levels_1.ogg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalAudio.play_music(LEVEL_1_THEME)
	animation_player.play("cutscene")

func _animation_finished() -> void:
	get_tree().change_scene_to_file("res://userInterface/screens/levelSelect/LevelSelect.tscn")
