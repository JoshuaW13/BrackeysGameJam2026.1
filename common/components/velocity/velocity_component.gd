extends Node2D
class_name VelocityComponent

@export var speed: float
var velocity: Vector2 = Vector2.ZERO

func accelerate_in_direction(direction: Vector2)->void:
	velocity = direction*speed

func move(body:CharacterBody2D)->Vector2:
	var prev_position: Vector2 = body.global_position
	body.velocity = velocity
	body.move_and_slide()
	return body.global_position - prev_position

func stop(body: CharacterBody2D)->void:
	body.velocity = Vector2.ZERO
