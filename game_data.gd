extends Node

const SAVE_PATH = "user://save.res"
var completed_levels: Dictionary = {}

func _ready():
	load_game()

func game_complete()->bool:
	return completed_levels.values().all(func(element): return element == true)

func mark_completed(level_name: String):
	print(level_name)
	completed_levels[level_name] = true
	save_game()	

func is_completed(level_name: String) -> bool:
	if not completed_levels.has(level_name):
		completed_levels[level_name] = false
		return false
	return completed_levels[level_name]

func save_game() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(completed_levels)
		file.close()

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		completed_levels = {}
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		completed_levels = file.get_var()
		file.close()
