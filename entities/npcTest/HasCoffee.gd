extends DialogueCondition
class_name HasCoffee

func is_met(context)->bool:
	return context.inventory.has_item_of_type(Item.ItemType.COFEE)
