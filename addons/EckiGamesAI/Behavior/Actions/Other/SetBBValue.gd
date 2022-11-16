class_name SetBBValue, "res://addons/EckiGamesAI/Icons/Cog.png"
extends BehaviorNode

export var valueName = ""
export var groupName = "default"
export var value : Array

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	blackboard.set(valueName, value[0], groupName)
	return SUCCESS 
