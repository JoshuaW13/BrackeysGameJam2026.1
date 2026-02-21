extends Node

@onready var _character_fx_player: AudioStreamPlayer = $PlayerCharacterFxPlayer
@onready var _inventory_fx_player: AudioStreamPlayer = $InventoryFxPlayer
@onready var _menu_fx_player: AudioStreamPlayer = $MenuFxPlayer
@onready var _music_player: AudioStreamPlayer = $MusicPlayer

var _fx_volume : float = 1.0
var _music_volume : float = 1.0

var fx_volume : float :
	get:
		return _fx_volume
	set(value):
		_fx_volume = clamp(value, 0.0, 2.0)
		_character_fx_player.volume_linear = _fx_volume
		_inventory_fx_player.volume_linear = _fx_volume
		_menu_fx_player.volume_linear = _fx_volume
		
var music_volume : float :
	get:
		return _music_volume
	set(value):
		_music_volume = clamp(value, 0.0, 2.0)
		_music_player.volume_linear = _music_volume
		

func play_character_fx(fx):
	_character_fx_player.stream = fx
	_character_fx_player.play()

func play_inventory_fx(fx):
	_inventory_fx_player.stream = fx
	_inventory_fx_player.play()

func play_menu_fx(fx):
	_menu_fx_player.stream = fx
	_menu_fx_player.play()

func play_music(track):
	_music_player.stream = track
	_music_player.play()
	
func _ready() -> void:
	fx_volume = 0.4
	music_volume = 0.4
