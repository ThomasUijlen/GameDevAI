class_name FilterAction, "res://addons/EckiGamesAI/Icons/Filter.png"
extends TargetAction

export var alwaysFilter = false
export var inverted = false

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	var targetNew = blackboard.get("TargetNew", null, targetName)
	if alwaysFilter: targetNew = true
	
	if targetNew == null: return FAILED
	if targetNew == false: return SUCCESS
	
	var targetList = blackboard.get("TargetList", null, targetName)
	if targetList == null: return FAILED
	
	if enabled: filterTargets(actor, blackboard, targetList)
	
	return SUCCESS

func filterTargets(actor, blackboard, targetList):
	pass
