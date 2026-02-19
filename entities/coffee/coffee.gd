extends PlaceableItem
class_name Coffee

enum Topping{
	NONE,
	CARAMEL,
	CHOCOLATE,
	MILK
}

var topping: Coffee.Topping = Topping.NONE

func _ready() -> void:
	if inventory_item == null:
		inventory_item = load("res://entities/coffee/coffee.tres")
	super._ready()

func _integrate_forces(state):
	var vel = state.get_linear_velocity()
	state.set_linear_velocity(Vector2(0, vel.y))
