class_name DetectTargetsInArea, "res://addons/EckiGamesAI/Icons/Area.png"
extends TargetAction

export var areaPath : NodePath
export var scanInterval = 1.0

var t = 0.0
var targetList = null

var area : Area

func _ready():
	area = get_node(areaPath)
	assert(area != null, "DetectTargetsInArea needs an Area")
	t = rand_range(0.0,scanInterval)

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	t += blackboard.get("delta")
	if t > scanInterval:
		targetList = null
		t = 0.0
	
	if targetList == null:
		targetList = area.get_overlapping_bodies()
		if targetList.has(actor): targetList.erase(actor)
		blackboard.set("TargetList", targetList, targetName)
		blackboard.set("TargetNew", true, targetName)
	else:
		blackboard.set("TargetNew", false, targetName)
	
	return SUCCESS
