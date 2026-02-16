extends CharacterBody2D
class_name Player

@onready var state_machine : StateMachine = %StateMachine
@onready var velocity_component : VelocityComponent = %VelocityComponent
@onready var gravity_component: GravityComponent = %GravityComponent

func _ready() -> void:
	state_machine.start()

func _physics_process(delta):
	if not is_on_floor():
		gravity_component.apply(delta)
	velocity_component.apply(self)
