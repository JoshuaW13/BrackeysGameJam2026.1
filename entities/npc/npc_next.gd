extends Resource
class_name NPCNext

func execute(runtime_args, _args = []):
	if runtime_args[0] is NPC:
		runtime_args[0].next()
