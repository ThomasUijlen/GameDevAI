class_name RefreshTargetList, "res://addons/EckiGamesAI/Icons/LoopDecorator.png"
extends TargetAction

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	blackboard.set("TargetNew", true, targetName)
	return SUCCESS
