extends NPC
class_name Guard

@onready var velocity_component : VelocityComponent = $VelocityComponent
@onready var gravity_component: GravityComponent = $GravityComponent

func _physics_process(delta: float) -> void:
	gravity_component.apply(delta)
	velocity_component.apply(self)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.stunned = true
