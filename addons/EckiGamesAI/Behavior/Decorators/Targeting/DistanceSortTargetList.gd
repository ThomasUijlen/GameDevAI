class_name DistanceSortTargetList, "res://addons/EckiGamesAI/Icons/RulerDecorator.png"
extends TargetAction

var ownBody : Spatial
export var inverted = false

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	ownBody = actor
	
	if inverted:
		blackboard.get("TargetList", [], targetName).sort_custom(self, "distanceSortInverted")
	else:
		blackboard.get("TargetList", [], targetName).sort_custom(self, "distanceSort")
	
	return SUCCESS

func distanceSortInverted(a, b):
	return a.global_transform.origin.distance_to(ownBody.global_transform.origin) > b.global_transform.origin.distance_to(ownBody.global_transform.origin)

func distanceSort(a, b):
	return a.global_transform.origin.distance_to(ownBody.global_transform.origin) < b.global_transform.origin.distance_to(ownBody.global_transform.origin)
