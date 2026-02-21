extends Node

@onready var _character_fx_player: AudioStreamPlayer = $PlayerCharacterFxPlayer
@onready var _inventory_fx_player: AudioStreamPlayer = $InventoryFxPlayer
@onready var _menu_fx_player: AudioStreamPlayer = $MenuFxPlayer
@onready var _dialogue_fx_player: AudioStreamPlayer = $DialogueFxPlayer
@onready var _world_fx_player: AudioStreamPlayer = $WorldFxPlayer
@onready var _music_track_1_player: AudioStreamPlayer = $MusicTrack1Player
@onready var _music_track_2_player: AudioStreamPlayer = $MusicTrack2Player

var _global_volume_modifier = 0.5

var _current_music_on_track_1 = true

var _fx_bus_index = AudioServer.get_bus_index("FX")
var _music_bus_index = AudioServer.get_bus_index("Music")

var _fx_volume: float = 1.0
var _music_volume: float = 1.0
var _music_track_1_volume: float = 1.0:
	set(value):
		_music_track_1_volume = value
		_music_track_1_player.volume_linear = _music_track_1_volume
var _music_track_2_volume: float = 0.0:
	set(value):
		_music_track_2_volume = value
		_music_track_2_player.volume_linear = _music_track_2_volume
var _music_fade_time: float = 1.0

var fx_volume : float:
	get:
		return _fx_volume
	set(value):
		_fx_volume = clamp(value, 0.0, 2.0)
		AudioServer.set_bus_volume_db(_fx_bus_index, linear_to_db(_fx_volume * _global_volume_modifier))
		
var music_volume : float:
	get:
		return _music_volume
	set(value):
		_music_volume = clamp(value, 0.0, 2.0)
		AudioServer.set_bus_volume_db(_music_bus_index, linear_to_db(_music_volume * _global_volume_modifier))
		

func play_character_fx(fx):
	_character_fx_player.stream = fx
	_character_fx_player.play()

func play_inventory_fx(fx):
	_inventory_fx_player.stream = fx
	_inventory_fx_player.play()

func play_menu_fx(fx):
	_menu_fx_player.stream = fx
	_menu_fx_player.play()
	
func play_world_fx(fx):
	_world_fx_player.stream = fx
	_world_fx_player.play()
	
var _dialogue_fx = load("res://audio/dialogue blip.wav")
var _dialogue_tween: Tween
	
func play_dialogue_fx(blips: int):
	if _dialogue_tween:
		_dialogue_tween.kill()
	_dialogue_tween = create_tween()
	for i in range(blips):
		_dialogue_tween.tween_callback(_play_dialogue_fx_with_random_pitch)
		_dialogue_tween.tween_interval(0.08)
		
func _play_dialogue_fx_with_random_pitch():
	_dialogue_fx_player.stream = _dialogue_fx
	_dialogue_fx_player.pitch_scale = randf_range(1.0, 1.3)
	_dialogue_fx_player.play()
	
var _track_switch_tween: Tween

func play_music(track):
	if _current_music_on_track_1:
		# switch to track 2
		_music_track_2_player.stream = track
		_music_track_2_player.play()
		_current_music_on_track_1 = false
		if _track_switch_tween:
			_track_switch_tween.kill()
		_track_switch_tween = create_tween().set_parallel(true)
		_track_switch_tween.tween_property(self, "_music_track_2_volume", 1.0, _music_fade_time)
		_track_switch_tween.tween_property(self, "_music_track_1_volume", 0.0, _music_fade_time)
		_track_switch_tween.finished.connect(func():
			_music_track_1_player.stop()
		)
	else:
		# switch to track 1
		_music_track_1_player.stream = track
		_music_track_1_player.play()
		_current_music_on_track_1 = true
		if _track_switch_tween:
			_track_switch_tween.kill()
		_track_switch_tween = create_tween().set_parallel(true)
		_track_switch_tween.tween_property(self, "_music_track_1_volume", 1.0, _music_fade_time)
		_track_switch_tween.tween_property(self, "_music_track_2_volume", 0.0, _music_fade_time)
		_track_switch_tween.finished.connect(func():
			_music_track_2_player.stop()
		)
		
var music_muffled: bool = false:
	set(value):
		music_muffled = value
		AudioServer.set_bus_effect_enabled(_music_bus_index, 0, music_muffled)
	

func _ready() -> void:
	fx_volume = _fx_volume
	music_volume = _music_volume
