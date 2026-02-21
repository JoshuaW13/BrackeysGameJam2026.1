extends DialogueFunction
class_name NPCComplete

func execute(runtime_args, _args = []):
	if runtime_args[0] is NPC:
		print("calling  completed on npc")
		runtime_args[0].complete()
