class_name ShuffleTargetList, "res://addons/EckiGamesAI/Icons/Random.png"
extends TargetAction

var ownBody : Spatial

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	ownBody = actor
	
	blackboard.get("TargetList", [], targetName).shuffle()
	
	return SUCCESS
