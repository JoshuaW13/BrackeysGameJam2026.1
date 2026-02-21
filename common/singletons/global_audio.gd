extends Node

@onready var _character_fx_player: AudioStreamPlayer = $PlayerCharacterFxPlayer
@onready var _inventory_fx_player: AudioStreamPlayer = $InventoryFxPlayer
@onready var _menu_fx_player: AudioStreamPlayer = $MenuFxPlayer
@onready var _music_player: AudioStreamPlayer = $MusicPlayer

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
