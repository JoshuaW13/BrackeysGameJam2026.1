extends PlaceableItem
class_name Coffee

func _ready() -> void:
	inventory_item = load("res://entities/coffee/coffee.tres")
	super._ready()

func _integrate_forces(state):
	var vel = state.get_linear_velocity()
	state.set_linear_velocity(Vector2(0, vel.y))
