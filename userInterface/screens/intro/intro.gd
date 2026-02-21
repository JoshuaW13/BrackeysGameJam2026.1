extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer

const LEVEL_SELECT_THEME = preload("res://audio/music/levels_1.ogg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalAudio.play_music(LEVEL_SELECT_THEME)
	animation_player.animation_finished.connect(_animation_finished)
	animation_player.play("cutscene")

func _animation_finished() -> void:
	get_tree().change_scene_to_file("res://userInterface/screens/levelSelect/LevelSelect.tscn")
