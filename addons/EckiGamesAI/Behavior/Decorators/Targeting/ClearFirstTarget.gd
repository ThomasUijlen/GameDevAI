class_name ClearFirstTarget, "res://addons/EckiGamesAI/Icons/Trash.png"
extends TargetAction

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	blackboard.get("TargetList", [], targetName).pop_front()
	return SUCCESS

