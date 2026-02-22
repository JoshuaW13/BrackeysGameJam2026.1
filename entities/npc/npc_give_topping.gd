extends DialogueFunction
class_name NPCGiveTopping

func execute(runtime_args, _args = []):
	var player = runtime_args[1]
	if player is Player:
		var topping = load(_args[0])
		var topping_item
		match topping:
			"caramel":
				topping_item = Caramel.new()
			"chocolate":
				topping_item = Chocolate.new()
			"milk":
				topping_item = Milk.new()
		for i in range(_args[1]):
			SignalBus.topping_picked_up.emit(topping_item)
