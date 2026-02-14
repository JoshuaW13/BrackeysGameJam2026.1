extends Node2D
class_name ExperienceComponent

signal experience_changed()

var level: int = 1
var experience: int = 0
var level_xp: int:
	get:
		return 2*level+3
var experience_to_next_level: int:
	get:
		return level_xp - experience
var percentage_of_next_level: float:
	get:
		return float(experience)/level_xp*100.0

func process_xp(captured_xp: xp)-> void:
	var remaining_xp = captured_xp.amount
	while remaining_xp > 0:
		if remaining_xp >= experience_to_next_level:
			remaining_xp -= experience_to_next_level
			level += 1
			experience =0
		else:
			experience += remaining_xp
			remaining_xp =0
	rpc("rpc_update_experience")

@rpc("any_peer", "reliable")
func rpc_update_experience()->void:
	experience_changed.emit()
