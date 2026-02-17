extends Node
class_name GravityComponent

@export var gravity: float = 2750
@export var velocity_component: VelocityComponent

func apply(delta: float) -> void:
	velocity_component.add_vertical(gravity * delta)
