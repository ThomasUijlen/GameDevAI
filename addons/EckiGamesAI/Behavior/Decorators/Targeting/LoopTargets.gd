class_name LoopTargets, "res://addons/EckiGamesAI/Icons/LoopDecorator.png"
extends TargetAction

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	var targetList : Array = blackboard.get("TargetList", [], targetName)
	if targetList.size() >= 2:
		var firstTarget = targetList.front()
		targetList.erase(firstTarget)
		targetList.push_back(firstTarget)
	
	return SUCCESS
