extends CharacterBody2D

@export var moving_platform : MovingPlatformResource
var start_position: Vector2
var target_position: Vector2
var moving_forward := true

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func _ready():
	start_position = global_position
	moving_platform.direction = moving_platform.direction.normalized()
	target_position = start_position + moving_platform.direction * moving_platform.distance

	_update_width()

func _physics_process(delta):
	var target = target_position if moving_forward else start_position
	var move_dir = (target - global_position).normalized()

	velocity = move_dir * moving_platform.speed
	move_and_slide()

	if global_position.distance_to(target) == 0:
		moving_forward = !moving_forward

func _update_width():
	pass
	#Need to base it off of 16 pix intervals
