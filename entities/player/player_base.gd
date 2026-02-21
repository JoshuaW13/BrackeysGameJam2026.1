extends CharacterBody2D
class_name Player

@export var player_resource : PlayerResource
@export var stunned: bool = false

@onready var state_machine : StateMachine = %StateMachine
@onready var velocity_component : VelocityComponent = %VelocityComponent
@onready var gravity_component: GravityComponent = %GravityComponent
@onready var inventory: Inventory = %Inventory
@onready var audioPlayer: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var walkSoundPlayer: AudioStreamPlayer2D = $WalkSoundPlayer
@onready var walkSoundTimer: Timer = $WalkSoundTimer

const PICKUP_SOUND = preload("res://audio/pickup.wav")
const DROP_SOUND = preload("res://audio/drop.wav")
const CYCLE_SOUND = preload("res://audio/cycle.wav")

var push_strength: float = 10

func _ready() -> void:
	state_machine.start()
	SignalBus.item_picked_up.connect(item_picked_up)
	SignalBus.topping_picked_up.connect(topping_picked_up)

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

func item_picked_up(item: PlaceableItem)->void:
	inventory.add_item(item.inventory_item)
	item.call_deferred("queue_free")
	play_pickup_audio()

func topping_picked_up(topping: Topping)->void:
	inventory.add_topping(topping)
	topping.call_deferred("queue_free")
	play_pickup_audio()

func play_pickup_audio()->void:
	audioPlayer.stream = PICKUP_SOUND
	audioPlayer.play()

func _input(_event: InputEvent)-> void:
	if stunned:
		return
	if _event.is_action_pressed("place"):
		var useResult : bool = inventory.use_item()
		if useResult:
			audioPlayer.stream = DROP_SOUND
			audioPlayer.play()
	if _event.is_action_pressed("cycle_inventory_right"):
		inventory.cycle_right()
		audioPlayer.stream = CYCLE_SOUND
		audioPlayer.play()
	if _event.is_action_pressed("cycle_inventory_left"):
		inventory.cycle_left()
		audioPlayer.stream = CYCLE_SOUND
		audioPlayer.play()
