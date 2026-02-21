extends Resource
class_name HappyGuard

func execute(runtime_args, _args=[]):
	if runtime_args[0] is Guard:
		var guard: Guard = runtime_args[0]
		guard.make_happy()
