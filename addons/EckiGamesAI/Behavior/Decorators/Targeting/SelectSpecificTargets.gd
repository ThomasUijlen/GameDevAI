class_name SelectSpecificTargets, "res://addons/EckiGamesAI/Icons/SpecificDecorator.png"
extends TargetAction

export(Array, NodePath) var targets

var targetList = null

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	if targetList == null:
		targetList = []
		for path in targets:
			targetList.append(get_node(path))
		
		blackboard.set("TargetList", targetList, targetName)
		blackboard.set("TargetNew", true, targetName)
	else:
		blackboard.set("TargetNew", false, targetName)
	
	return SUCCESS
