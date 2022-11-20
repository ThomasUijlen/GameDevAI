class_name DestroyAllCrumbs, "res://addons/EckiGamesAI/Icons/Trash.png"
extends BehaviorNode

export var crumbsName = ""


func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	var crumbList = blackboard.get("CrumbList", [], crumbsName)
	
	for crumb in crumbList:
		crumb.call_deferred("expire")
	
	return SUCCESS
