extends Control

@onready var pause_button : Button = $PauseButton
@onready var pause_panel : Panel = $Panel
@onready var continue_button : Button = $Panel/BoxContainer/VBoxContainer/ContinueButton
@onready var restart_button : Button = $Panel/BoxContainer/VBoxContainer/RestartButton
@onready var main_button : Button = $Panel/BoxContainer/VBoxContainer/MainButton
@onready var sfx_slider : Slider = $Panel/SFXSlider
@onready var music_slider : Slider = $Panel/MusicSlider

var BUTTON_SOUND = load("res://audio/menubutton.wav")

func _ready() -> void:
	sfx_slider.value = GlobalAudio.fx_volume
	music_slider.value = GlobalAudio.music_volume
	
	pause_button.pressed.connect(_on_pause_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	main_button.pressed.connect(_on_main_pressed)
	sfx_slider.value_changed.connect(_on_sfx_slider_changed)
	sfx_slider.drag_ended.connect(_on_sfx_slider_drag_stopped)
	music_slider.value_changed.connect(_on_music_slider_changed)

func _on_pause_pressed() -> void:
	pause_panel.show()
	pause_button.hide()
		
	get_tree().paused = true
	GlobalAudio.music_muffled = true
	
func _on_continue_pressed() -> void:
	get_tree().paused = false
	GlobalAudio.music_muffled = false
	pause_panel.hide()
	pause_button.show()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	GlobalAudio.music_muffled = false
	var current_scene = get_tree().current_scene
	if current_scene:
		get_tree().reload_current_scene()

func _on_main_pressed() -> void:
	get_tree().paused = false
	GlobalAudio.music_muffled = false
	get_tree().change_scene_to_file("res://userInterface/screens/levelSelect/LevelSelect.tscn")
	
func _on_sfx_slider_changed(value: float) -> void:
	GlobalAudio.fx_volume = value

func _on_sfx_slider_drag_stopped(_value) -> void:
	GlobalAudio.play_menu_fx(BUTTON_SOUND)

func _on_music_slider_changed(value: float) -> void:
	GlobalAudio.music_volume = value
