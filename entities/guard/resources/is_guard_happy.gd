extends DialogueCondition
class_name IsGuardHappy

func is_met(_runtime_args, _args=[])->bool:
	var maybe_guard = _runtime_args[1]
	if maybe_guard is Guard:
		if maybe_guard.happy:
			return true
	return false
