class_name CopyAndInsertTargetList, "res://addons/EckiGamesAI/Icons/Duplicate.png"
extends TargetAction

export var groupToCopy = ""

var targetList = null

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	var targetNew = blackboard.get("TargetNew", null, groupToCopy)
	if targetNew == true: targetList = null
	
	if targetList:
		blackboard.set("TargetNew", false, targetName)
		return SUCCESS
	
	var groupToCopy = blackboard.get("TargetList", [], groupToCopy)
	targetList = blackboard.get("TargetList", [], targetName)
	
	for target in groupToCopy:
		if !targetList.has(target): targetList.append(target)
	
	blackboard.set("TargetList", targetList, targetName)
	blackboard.set("TargetNew", true, targetName)
	
	return SUCCESS

