extends Resource
class_name NPCGive

func execute(runtime_args, _args = []):
	var player = runtime_args[1]
	if player is Player:
		var ITEM_RES = load(_args[0])
		for i in range(_args[1]):
			var new_item : Item = ITEM_RES.duplicate(true)
			new_item.id = player.player_resource.item_id
			player.player_resource.item_id += 1
			player.inventory.add_item(new_item)
