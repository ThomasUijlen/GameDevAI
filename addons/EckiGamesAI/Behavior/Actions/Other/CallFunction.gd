class_name CallFunction, "res://addons/EckiGamesAI/Icons/Cog.png"
extends BehaviorNode

export var nodePath : NodePath
export var functionName = ""
export var parameters : Array

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	var node : Node = get_node(nodePath)
	
	assert(node.has_method(functionName), "Node does not contain a method called "+functionName)
	
	if parameters.empty():
		node.call(functionName)
	else:
		node.callv(functionName, parameters)
	
	return SUCCESS
