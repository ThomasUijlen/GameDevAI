class_name TargetBreadcrumbs, "res://addons/EckiGamesAI/Icons/Breadcrumbs.png"
extends TargetAction

export var scanInterval = 60

var t = 0.0
var targetList = null

func _ready():
	t = rand_range(0.0,scanInterval)

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	t += blackboard.get("delta")
	if t > scanInterval:
		targetList = null
		t = 0.0
	
	if targetList == null:
		targetList = blackboard.get("CrumbList", [], targetName)
		blackboard.set("TargetList", targetList, targetName)
		blackboard.set("TargetNew", true, targetName)
	else:
		blackboard.set("TargetNew", false, targetName)
	
	return SUCCESS
