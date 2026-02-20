extends Area2D
class_name ToppingCollector

signal topping_received(topping: Topping)

func _on_area_entered(area: Area2D) -> void:
	var maybeTopping = area.get_parent()
	if maybeTopping is Topping:
		topping_received.emit(maybeTopping)
