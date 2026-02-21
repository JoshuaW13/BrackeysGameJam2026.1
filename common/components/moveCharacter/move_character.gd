extends Node2D
class_name MoveCharacter

signal character_moved

enum DIRECTION{
	LEFT,
	RIGHT
}
@export var move_distance: float = 50
@export var duration: float = 1.25

func move(character: CharacterBody2D, direction: DIRECTION) -> void:
	var dir := -1 if direction == DIRECTION.LEFT else 1
	var target_x := character.global_position.x + dir * move_distance
	
	var tween = create_tween()
	tween.tween_property(character, "global_position:x", target_x, duration)
	tween.finished.connect(_on_tween_finished)

func _on_tween_finished() -> void:
	character_moved.emit()
