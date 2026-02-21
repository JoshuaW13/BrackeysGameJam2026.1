extends Node

@onready var character_fx_player: AudioStreamPlayer = $PlayerCharacterFxPlayer
@onready var inventory_fx_player: AudioStreamPlayer = $InventoryFxPlayer
@onready var menu_fx_player: AudioStreamPlayer = $MenuFxPlayer
@onready var music_player: AudioStreamPlayer = $MusicPlayer

func play_character_fx(fx):
	character_fx_player.stream = fx
	character_fx_player.play()
	
func play_inventory_fx(fx):
	inventory_fx_player.stream = fx
	inventory_fx_player.play()

func play_menu_fx(fx):
	menu_fx_player.stream = fx
	menu_fx_player.play()

func play_music(track):
	music_player.stream = track
	music_player.play()
