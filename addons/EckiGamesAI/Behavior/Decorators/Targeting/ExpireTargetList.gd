class_name ExpireTargetList, "res://addons/EckiGamesAI/Icons/Trash.png"
extends TargetAction

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	blackboard.set("TargetNew", false, targetName)
	return SUCCESS
