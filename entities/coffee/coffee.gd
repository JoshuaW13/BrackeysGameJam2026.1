extends PlaceableItem
class_name Coffee

enum Topping{
	NONE,
	CARAMEL,
	CHOCOLATE,
	MILK
}
var COFEE_SPRITE: Texture2D = load("res://entities/coffee/black_coffee.png") 
var CARAMEL_SPRITE: Texture2D = load("res://entities/coffee/caramel_coffee.png") 
var CHOCOLATE_SPRITE: Texture2D = load("res://entities/coffee/chocolate_coffee.png")
var MILK_SPRITE: Texture2D = load("res://entities/coffee/milk_coffee.png")

var topping: Coffee.Topping = Topping.NONE:
	set(new_topping):
		match new_topping:
			Topping.CARAMEL:
				sprite.texture = CARAMEL_SPRITE
			Topping.CHOCOLATE:
				sprite.texture = CHOCOLATE_SPRITE
			Topping.MILK:
				sprite.texture = MILK_SPRITE

func _ready() -> void:
	if inventory_item == null:
		inventory_item = load("res://entities/coffee/coffee.tres")
	super._ready()

func _integrate_forces(state):
	var vel = state.get_linear_velocity()
	state.set_linear_velocity(Vector2(0, vel.y))
