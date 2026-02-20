extends DialogueFunction
class_name NPCComplete

func execute(runtime_args, args):
	runtime_args[0].complete()
