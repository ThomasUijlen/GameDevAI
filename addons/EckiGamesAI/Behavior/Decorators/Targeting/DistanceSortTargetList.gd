class_name DistanceSortTargetList, "res://addons/EckiGamesAI/Icons/RulerDecorator.png"
extends TargetAction

var ownBody : Spatial
export var fastMath = true
export var inverted = false

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	ownBody = actor
	
	if fastMath:
		if inverted:
			blackboard.get("TargetList", [], targetName).sort_custom(self, "distanceSortFastInverted")
		else:
			blackboard.get("TargetList", [], targetName).sort_custom(self, "distanceSortFast")
	else:
		if inverted:
			blackboard.get("TargetList", [], targetName).sort_custom(self, "distanceSortInverted")
		else:
			blackboard.get("TargetList", [], targetName).sort_custom(self, "distanceSort")
	
	return SUCCESS

func distanceSortFastInverted(a, b):
	a.global_transform.origin.distance_squared_to(ownBody.global_transform.origin) > b.global_transform.origin.distance_squared_to(ownBody.global_transform.origin)

func distanceSortInverted(a, b):
	a.global_transform.origin.distance_to(ownBody.global_transform.origin) > b.global_transform.origin.distance_to(ownBody.global_transform.origin)

func distanceSortFast(a, b):
	a.global_transform.origin.distance_squared_to(ownBody.global_transform.origin) < b.global_transform.origin.distance_squared_to(ownBody.global_transform.origin)

func distanceSort(a, b):
	a.global_transform.origin.distance_to(ownBody.global_transform.origin) < b.global_transform.origin.distance_to(ownBody.global_transform.origin)
