extends DialogueFunction
class_name NPCComplete

func execute(runtime_args, args):
	if runtime_args is NPC:
		runtime_args[0].complete()
