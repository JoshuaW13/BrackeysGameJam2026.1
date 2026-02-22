extends DialogueFunction
class_name NPCGiveTopping

func execute(runtime_args, _args = []):
	var player = runtime_args[1]
	if player is Player:
		var topping = _args[0]
		var topping_item : Topping
		match topping:
			"caramel":
				topping_item = Caramel.new()
				topping_item.type = Coffee.Topping.CARAMEL
			"chocolate":
				topping_item = Chocolate.new()
				topping_item.type = Coffee.Topping.CHOCOLATE
			"milk":
				topping_item = Milk.new()
				topping_item.type = Coffee.Topping.MILK
		for i in range(_args[1]):
			print("Emit chocolate", topping_item.type)
			SignalBus.topping_picked_up.emit(topping_item)
