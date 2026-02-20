extends Resource
class_name Item

enum ItemType{
	COFFEE,
	BOX
}
var type: ItemType
@export var scene: PackedScene
@export var texture: Texture2D
@export var id: int = 1
var topping: Coffee.Topping = Coffee.Topping.NONE:
	set(new_topping):
		topping = new_topping
		match new_topping:
			Coffee.Topping.CARAMEL:
				texture = CARAMEL_SPRITE
			Coffee.Topping.CHOCOLATE:
				texture = CHOCOLATE_SPRITE
			Coffee.Topping.MILK:
				texture = MILK_SPRITE
var COFFEE_SPRITE: Texture2D = load("res://entities/coffee/black_coffee.png") 
var CARAMEL_SPRITE: Texture2D = load("res://entities/coffee/caramel_coffee.png") 
var CHOCOLATE_SPRITE: Texture2D = load("res://entities/coffee/chocolate_coffee.png")
var MILK_SPRITE: Texture2D = load("res://entities/coffee/milk_coffee.png")
