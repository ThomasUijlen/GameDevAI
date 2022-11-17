class_name ValidInstanceFilter, "res://addons/EckiGamesAI/Icons/CogFilter.png"
extends FilterAction

func filterTargets(actor, blackboard, targetList):
	var targetsToRemove = []
	
	for target in targetList:
		if (!inverted and !is_instance_valid(target)) or (inverted and is_instance_valid(target)):
			targetsToRemove.append(target)
	
	for target in targetsToRemove:
		targetList.erase(target)
