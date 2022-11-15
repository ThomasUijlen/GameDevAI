extends FlockingNode

export var boxSize = 10

func _physics_process(delta):
	var parent : Spatial = get_parent()
	
	var direction = Vector3.ZERO
	
	direction.x += evalPosition(ownBody.global_translation.x, -boxSize, boxSize)
	direction.y += evalPosition(ownBody.global_translation.y, -boxSize, boxSize)
	direction.z += evalPosition(ownBody.global_translation.z, -boxSize, boxSize)
	
	ownBody.flockingDirection += direction.normalized()

func evalPosition(currentValue, minValue, maxValue) -> float:
	if currentValue > maxValue:
		return -1.0
	elif currentValue < minValue:
		return 1.0
	
	return 0.0
