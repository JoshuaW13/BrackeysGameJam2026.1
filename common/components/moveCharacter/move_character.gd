extends Node2D
class_name MoveCharacter

signal character_moved

enum DIRECTION{
	LEFT,
	RIGHT
}
@export var move_distance: float = 50
@export var duration: float = 0.75

func move(character: CharacterBody2D, direction: DIRECTION) -> void:
	var dir_vector := Vector2.LEFT if direction == DIRECTION.LEFT else Vector2.RIGHT
	var target = character.global_position + dir_vector * move_distance
	
	var tween = create_tween()
	tween.tween_property(character, "global_position", target, duration)
	tween.finished.connect(_on_tween_finished)

func _on_tween_finished() -> void:
	character_moved.emit()
