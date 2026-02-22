extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var skip_button : Button = $Camera2D/SkipButton

var OPEN_SOUND = load("res://audio/elevator open.wav")
var CLOSE_SOUND = load("res://audio/elevator close.wav")
var FINAL_LEVEL_THEME = load("res://audio/music/final_theme.ogg")

func _ready() -> void:
	GameData.final_cutscene_seen = true
	skip_button.pressed.connect(_load_credits)
	GlobalAudio.play_music(FINAL_LEVEL_THEME)
	animation_player.play("cutscene")

func _play_dialogue_sound(blips: int) -> void:
	GlobalAudio.play_dialogue_fx(blips)
	
func _play_elevator_sound(open: bool) -> void:
	if open:
		GlobalAudio.play_world_fx(OPEN_SOUND)
	else:
		GlobalAudio.play_world_fx(CLOSE_SOUND)

func _animation_finished() -> void:
	_load_credits()

func _load_credits() -> void:
	get_tree().change_scene_to_file("res://userInterface/screens/credits/credits.tscn")
