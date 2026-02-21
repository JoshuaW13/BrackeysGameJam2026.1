extends Control

@onready var continue_button : Button = $BoxContainer/VBoxContainer/ContinueButton
@onready var restart_button : Button = $BoxContainer/VBoxContainer/RestartButton
@onready var main_button : Button = $BoxContainer/VBoxContainer/MainButton
@onready var sfx_slider : Slider = $SFXSlider
@onready var music_slider : Slider = $MusicSlider

func _ready() -> void:
	sfx_slider.value = GlobalAudio.fx_volume
	music_slider.value = GlobalAudio.music_volume
	
	continue_button.pressed.connect(_on_continue_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	main_button.pressed.connect(_on_main_pressed)
	sfx_slider.value_changed.connect(_on_sfx_slider_changed)
	music_slider.value_changed.connect(_on_music_slider_changed)

func _on_continue_pressed() -> void:
	get_tree().paused = false
	hide()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	var current_scene = get_tree().current_scene
	if current_scene:
		get_tree().reload_current_scene()

func _on_main_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://userInterface/screens/levelSelect/LevelSelect.tscn")
	
func _on_sfx_slider_changed(value: float) -> void:
	GlobalAudio.fx_volume = value

func _on_music_slider_changed(value: float) -> void:
	GlobalAudio.music_volume = value
