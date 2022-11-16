class_name SelectTargetsFromGroup, "res://addons/EckiGamesAI/Icons/SpecificDecorator.png"
extends TargetAction

export var groupName = ""

var targetList = null

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	if targetList == null:
		targetList = get_tree().get_nodes_in_group(groupName)
		
		blackboard.set("TargetList", targetList, targetName)
		blackboard.set("TargetNew", true, targetName)
	else:
		blackboard.set("TargetNew", false, targetName)
	
	return SUCCESS
