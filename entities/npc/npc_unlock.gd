extends DialogueFunction
class_name NPCUnlock

func execute(runtime_args, args):
	if runtime_args[0] is NPC:
		print(runtime_args[0], args[0])
		runtime_args[0].unlock_item(args[0])
