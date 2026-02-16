extends CharacterBody2D
class_name Player

@onready var state_machine : StateMachine = %StateMachine
@onready var velocity_component : VelocityComponent = %VelocityComponent
@onready var gravity_component: GravityComponent = %GravityComponent
@onready var inventory: Inventory = %Inventory

var push_strength: float = 10

func _ready() -> void:
	state_machine.start()
	SignalBus.item_picked_up.connect(item_picked_up)

func _physics_process(delta):
	if not is_on_floor():
		gravity_component.apply(delta)
	velocity_component.apply(self)
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider is RigidBody2D:
			var normal = collision.get_normal()
			
			if abs(normal.y) < 0.7:
				var push_dir = Vector2(-normal.x, 0).normalized()
				collider.apply_central_impulse(push_dir * push_strength)

func item_picked_up(item: Box)->void:
	inventory.add_item(item.box_item)
	item.queue_free()

func _input(_event: InputEvent)-> void:
	if _event.is_action_pressed("place"):
		inventory.use_item()
