class_name LOSFilter, "res://addons/EckiGamesAI/Icons/Eye.png"
extends FilterAction

export var extraHeight = 0.0

var ray : RayCast

func _ready():
	ray = get_node("RayCast")
	assert(ray != null, "LOSFilter needs a RayCast")

func filterTargets(actor, blackboard, targetList):
	var targetsToRemove = []
	
	for target in targetList:
		var targetPosition = target.global_transform.origin
		if (!inverted and !inLOS(actor, targetPosition, target)) or (inverted and inLOS(actor, targetPosition, target)):
			targetsToRemove.append(target)
	
	for target in targetsToRemove:
		targetList.erase(target)

func inLOS(actor, targetPosition, target) -> bool:
	ray.global_transform.origin = actor.global_transform.origin
	ray.global_transform.origin += actor.global_transform.basis.y * extraHeight
	
	ray.look_at(targetPosition, actor.global_transform.basis.y)
	ray.cast_to = Vector3(0,0,-actor.global_transform.origin.distance_to(targetPosition))
	
	ray.force_raycast_update()
	if ray.is_colliding():
		return target == ray.get_collider()
	return true
