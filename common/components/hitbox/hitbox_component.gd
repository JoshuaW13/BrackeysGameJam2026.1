extends Area2D
class_name HitboxComponent

signal hurtbox_hit(area:Area2D)

@export var damage: float = 0
var collisision_exceptions: Array[Area2D]

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent and collisision_exceptions.find(area)==-1:
		hurtbox_hit.emit(area)

func enable()->void:
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)

func disable()->void:
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
