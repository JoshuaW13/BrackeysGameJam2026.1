extends Area2D
class_name XpCollector

signal xp_received(xp: xp)

func _on_area_entered(area: Area2D) -> void:
	var maybeXp = area.get_parent()
	if maybeXp is xp:
		xp_received.emit(maybeXp)
