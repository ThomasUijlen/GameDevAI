extends Spatial

export var boxSize = 10

func _physics_process(delta):
	var parent : Spatial = get_parent()
	parent.global_translation.x += evalPosition(global_translation.x, -boxSize, boxSize)
	parent.global_translation.y += evalPosition(global_translation.y, -boxSize, boxSize)
	parent.global_translation.z += evalPosition(global_translation.z, -boxSize, boxSize)

func evalPosition(currentValue, minValue, maxValue) -> float:
	if currentValue > maxValue:
		return -boxSize * 2
	elif currentValue < minValue:
		return boxSize * 2
	
	return 0.0
