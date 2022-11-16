class_name SpawnBreadcrumbs, "res://addons/EckiGamesAI/Icons/Breadcrumbs.png"
extends TargetAction

const breadcrumbScene = preload("res://addons/EckiGamesAI/Behavior/Decorators/Targeting/Breadcrumbs/Breadcrumb.tscn")

enum MODE {
	SINGLE_TARGET,
	ALL_TARGETS
}

export(MODE) var mode = MODE.SINGLE_TARGET
export var crumbsName = ""

var crumbList = null

var t = rand_range(0.0, 1.0)
func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	t += blackboard.get("delta")
	if t < 1.0: return SUCCESS
	t = 0.0
	
	if crumbList == null:
		crumbList = blackboard.get("CrumbList", [], crumbsName)
		blackboard.set("CrumbList", crumbList, crumbsName)
	
	var targetList = blackboard.get("TargetList", [], targetName)
	if targetList.empty(): return SUCCESS
	
	match(mode):
		MODE.SINGLE_TARGET:
			spawnBreadcrumb(targetList[0].global_transform.origin)
		MODE.ALL_TARGETS:
			for target in targetList:
				spawnBreadcrumb(target.global_transform.origin)
	
	return SUCCESS

func spawnBreadcrumb(position):
	var breadcrumb = breadcrumbScene.instance()
	crumbList.push_front(breadcrumb)
	breadcrumb.crumbList = crumbList
	get_tree().current_scene.add_child(breadcrumb)
	breadcrumb.global_transform.origin = position
