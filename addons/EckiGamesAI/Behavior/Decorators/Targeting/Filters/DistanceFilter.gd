class_name DistanceFilter, "res://addons/EckiGamesAI/Icons/Ruler.png"
extends FilterAction

export var distance = 10.0
export var ignoreY = true

func filterTargets(actor, blackboard, targetList):
	var targetsToRemove = []
	
	for target in targetList:
		if (!inverted and !withinDistance(actor,target)) or (inverted and withinDistance(actor,target)):
			targetsToRemove.append(target)
	
	for target in targetsToRemove:
		targetList.erase(target)

func withinDistance(nodeA : Spatial, nodeB : Spatial):
	var localTranslation = nodeA.to_local(nodeB.global_transform.origin)
	if ignoreY: localTranslation.y = 0
	
	return localTranslation.length() <= distance
