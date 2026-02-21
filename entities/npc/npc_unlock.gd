extends DialogueFunction
class_name NPCUnlock

func execute(runtime_args, _args = []):
	if runtime_args[0] is NPC:
		runtime_args[0].unlock_item(_args[0])
