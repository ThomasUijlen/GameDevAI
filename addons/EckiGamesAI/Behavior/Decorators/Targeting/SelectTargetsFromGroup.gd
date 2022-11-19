class_name SelectTargetsFromGroup, "res://addons/EckiGamesAI/Icons/SpecificSelect.png"
extends TargetAction

export var groupName = ""
export var scanInterval = 1.0

var t = 0.0
var targetList = null

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	t += blackboard.get("delta")
	if t > scanInterval:
		targetList = null
		t = 0.0
	
	if targetList == null:
		targetList = get_tree().get_nodes_in_group(groupName)
		
		blackboard.set("TargetList", targetList, targetName)
		blackboard.set("TargetNew", true, targetName)
	else:
		blackboard.set("TargetNew", false, targetName)
	
	return SUCCESS
