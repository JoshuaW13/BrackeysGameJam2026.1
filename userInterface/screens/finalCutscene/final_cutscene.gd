extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("cutscene")

func _animation_finished() -> void:
	get_tree().change_scene_to_file("res://userInterface/screens/levelSelect/LevelSelect.tscn")
