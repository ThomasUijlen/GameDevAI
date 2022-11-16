class_name FOVFilter, "res://addons/EckiGamesAI/Icons/Eye.png"
extends FilterAction

export var fov = 30.0

var dotLimit = 0.0

func _ready():
	dotLimit = range_lerp(fov, 0, 360, 1, -1)

func filterTargets(actor, blackboard, targetList):
	var targetsToRemove = []
	
	for target in targetList:
		var targetPosition = target.global_transform.origin
		if (!inverted and !inFOV(actor, targetPosition)) or (inverted and inFOV(actor, targetPosition)):
			targetsToRemove.append(target)
	
	for target in targetsToRemove:
		targetList.erase(target)

func inFOV(actor, targetPosition) -> bool:
	var forward : Vector3 = actor.getForward()
	var direction = actor.global_transform.origin.direction_to(targetPosition)
	return forward.dot(direction) > dotLimit
