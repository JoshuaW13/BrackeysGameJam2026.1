extends DialogueCondition
class_name HasCaramelCoffee

func is_met(runtime_args, _args)->bool:
	var player = runtime_args[0]
	if player is Player:
		return player.inventory.holding_item_of_type(Item.ItemType.COFFEE)
	return false
