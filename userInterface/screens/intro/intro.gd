extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var skip_button : Button = $SkipButton

var OPEN_SOUND = load("res://audio/elevator open.wav")
var CLOSE_SOUND = load("res://audio/elevator close.wav")
var LEVEL_1_THEME = load("res://audio/music/levels_1.ogg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalAudio.play_music(LEVEL_1_THEME)
	animation_player.play("cutscene")
	skip_button.pressed.connect(_load_level_select_scene)

func _play_dialogue_sound(blips: int) -> void:
	GlobalAudio.play_dialogue_fx(blips)
	
func _play_elevator_sound(open: bool) -> void:
	if open:
		GlobalAudio.play_world_fx(OPEN_SOUND)
	else:
		GlobalAudio.play_world_fx(CLOSE_SOUND)

func _animation_finished() -> void:
	_load_level_select_scene()

func _load_level_select_scene() -> void:
	get_tree().change_scene_to_file("res://userInterface/screens/levelSelect/LevelSelect.tscn")
