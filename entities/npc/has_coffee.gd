extends DialogueCondition
class_name HasCoffee

func is_met(runtime_args, args)->bool:
	if runtime_args[0] is Player:
		return runtime_args[0].inventory.has_item_of_type(Item.ItemType.COFFEE)
	return false
