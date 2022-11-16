class_name HasTarget, "res://addons/EckiGamesAI/Icons/QuestionMark.png"
extends TargetAction

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	if hasTarget(actor, blackboard):
		return SUCCESS
	else:
		return FAILED

func hasTarget(actor, blackboard):
	var targetList = blackboard.get("TargetList", [], targetName)
	return !targetList.empty()
