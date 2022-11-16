class_name CallFunction, "res://addons/EckiGamesAI/Icons/Cog.png"
extends TargetAction

export var nodePath : NodePath
export var functionName = ""
export var parameters : Array

var target = null

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	selectTarget(actor, blackboard)
	if target == null: return FAILED
	
	assert(target.has_method(functionName), "Target does not contain a method called "+functionName)
	
	if parameters.empty():
		target.call(functionName)
	else:
		target.callv(functionName, parameters)
	
	return SUCCESS

func selectTarget(actor, blackboard):
	var targetList = blackboard.get("TargetList", [], targetName)
	if targetList.empty():
		target = null
		return
	
	target = targetList[0]
