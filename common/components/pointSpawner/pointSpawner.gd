extends Node2D
class_name PointSpawner

var origin : Vector2 = Vector2(0,0)
var max_distance: float = 0.0

func spawn(scene: PackedScene) -> void:
	var scene_instance: Node2D = scene.instantiate()

	var angle: float = randf() * TAU
	var distance_from_origin: float = randf() * max_distance
	var offset: Vector2 = Vector2(cos(angle), sin(angle)) * distance_from_origin
	
	scene_instance.position = origin + offset
	get_tree().current_scene.call_deferred("add_child", scene_instance)
