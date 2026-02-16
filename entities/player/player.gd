extends CharacterBody2D
class_name Player

@onready var state_machine : StateMachine = %StateMachine
@onready var velocity_component : VelocityComponent = %VelocityComponent
@onready var gravity_component: GravityComponent = %GravityComponent
@onready var inventory: Inventory = %Inventory

var push_strength: float = 5000

func _ready() -> void:
	state_machine.start()

func _physics_process(delta):
	if not is_on_floor():
		gravity_component.apply(delta)
	velocity_component.apply(self)
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is RigidBody2D:
			var push_dir = collision.get_normal()
			var horizontal_dir = Vector2(-push_dir.x, 0).normalized()
			collider.apply_central_force(horizontal_dir * push_strength)

func _input(_event: InputEvent)-> void:
	if _event.is_action_pressed("place"):
		inventory.use_item()
