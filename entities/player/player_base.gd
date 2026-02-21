extends CharacterBody2D
class_name Player

@export var player_resource : PlayerResource
@onready var state_machine : StateMachine = %StateMachine
@onready var velocity_component : VelocityComponent = %VelocityComponent
@onready var gravity_component: GravityComponent = %GravityComponent
@onready var inventory: Inventory = %Inventory
@onready var walkSoundTimer: Timer = $WalkSoundTimer
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var dialogue_panel: DialoguePanel = $Camera2D/DialoguePanel

var PICKUP_SOUND = load("res://audio/pickup.wav")
var DROP_SOUND = load("res://audio/drop.wav")
var CYCLE_SOUND = load("res://audio/cycle.wav")

var push_strength: float = 10
var can_move: bool = true

func _ready() -> void:
	state_machine.start()
	SignalBus.item_picked_up.connect(item_picked_up)
	SignalBus.topping_picked_up.connect(topping_picked_up)

func _physics_process(delta):
	if not can_move:
		velocity = Vector2.ZERO
		return

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

func item_picked_up(item: PlaceableItem)->void:
	#if is_on_floor():
	inventory.add_item(item.inventory_item)
	item.call_deferred("queue_free")
	GlobalAudio.play_inventory_fx(PICKUP_SOUND)

func topping_picked_up(topping: Topping)->void:
	inventory.add_topping(topping)
	topping.call_deferred("queue_free")
	GlobalAudio.play_inventory_fx(PICKUP_SOUND)
	
func _input(_event: InputEvent)-> void:
	if get_viewport().gui_get_hovered_control() != null:
		return
	if not can_move:
		return
		
	if state_machine.current_state is Stunned:
		return
	if _event.is_action_pressed("place"):
		var useResult : bool = inventory.use_item()
		if useResult:
			GlobalAudio.play_inventory_fx(DROP_SOUND)
	if _event.is_action_pressed("cycle_inventory_right"):
		inventory.cycle_right()
		GlobalAudio.play_inventory_fx(CYCLE_SOUND)
	if _event.is_action_pressed("cycle_inventory_left"):
		inventory.cycle_left()
		GlobalAudio.play_inventory_fx(CYCLE_SOUND)

func stun()->void:
	var current_state: State = state_machine.current_state
	current_state.transition.emit(current_state, "Stunned")

func release()->void:
	var current_state: State = state_machine.current_state
	if current_state is Stunned:
		current_state.transition.emit(current_state, "Idle")
