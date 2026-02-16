extends Node2D
class_name VelocityComponent

@export var speed: float = 200.0
var velocity: Vector2 = Vector2.ZERO

func set_horizontal(direction: float) -> void:
	velocity.x = direction * speed

func add_vertical(amount: float) -> void:
	velocity.y += amount

func apply(body: CharacterBody2D) -> void:
	body.velocity = velocity
	body.move_and_slide()
	velocity = body.velocity
