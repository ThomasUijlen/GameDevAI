class_name CopyTargetList, "res://addons/EckiGamesAI/Icons/Duplicate.png"
extends TargetAction

export var groupToCopy = ""

var targetList = null

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	if targetList:
		blackboard.set("TargetNew", false, targetName)
	
	var targetNew = blackboard.get("TargetNew", null, groupToCopy)
	if targetNew == true:
		targetList = null
	else:
		return SUCCESS
	
	targetList = blackboard.get("TargetList", [], groupToCopy).duplicate()
	
	blackboard.set("TargetList", targetList, targetName)
	blackboard.set("TargetNew", true, targetName)
	
	return SUCCESS
