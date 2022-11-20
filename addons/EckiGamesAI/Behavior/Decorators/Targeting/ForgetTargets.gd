class_name ForgetTargets, "res://addons/EckiGamesAI/Icons/Trash.png"
extends TargetAction

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	var memory : Dictionary = blackboard.get("Memory", {}, targetName)
	
	for target in memory:
		print(target)
		memory[target] = -100000000
	
	blackboard.set("TargetList", memory.keys(), targetName)
	return SUCCESS
