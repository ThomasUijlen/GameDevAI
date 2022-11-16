class_name ClearTargetList, "res://addons/EckiGamesAI/Icons/Trash.png"
extends TargetAction

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	blackboard.get("TargetList", [], targetName).clear()
	return SUCCESS

