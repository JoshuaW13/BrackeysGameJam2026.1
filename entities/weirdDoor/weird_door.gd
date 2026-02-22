extends Node2D
class_name WeirdDorr

@onready var interact_area : Area2D = $Area2D

var is_in_area : bool = false
var OPEN_SOUND = load("res://audio/elevator open.wav")

func _ready():
	interact_area.body_entered.connect(_on_body_entered)
	interact_area.body_exited.connect(_on_body_exited)

func _input(event):
	if event.is_action_pressed("interact") and is_in_area:
		interact()
		
func interact():
	GlobalAudio.play_world_fx(OPEN_SOUND)
	get_tree().change_scene_to_file("res://userInterface/screens/levelSelect/LevelSelect.tscn")

func _on_body_entered(body):
	is_in_area = true

func _on_body_exited(body):
	is_in_area = false
