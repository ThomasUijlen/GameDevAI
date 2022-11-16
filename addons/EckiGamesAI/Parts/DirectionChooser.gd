class_name DirectionChooser
extends Spatial

const DIRECTION_SCENE = preload("res://addons/EckiGamesAI/Parts/DirectionRay.tscn")
export var avoidanceDistance = 2.0
export var movementIntensity = 1.0

var directions = []

func _ready():
	var angle = deg2rad(360/16.0)
	
	for i in range(16):
		var direction = DIRECTION_SCENE.instance()
		direction.setDistance(avoidanceDistance)
		add_child(direction)
		direction.rotation.y = i*angle
		directions.append(direction)

func getDirection() -> Vector3:
	var bestLength = 0.0
	var bestDirection = null
	
	for direction in directions:
		if direction.blocked(): continue
		if bestDirection == null or direction.length > bestLength:
			bestLength = direction.length
			bestDirection = direction
	
	if bestLength <= 0.0: return Vector3.ZERO
	bestDirection.select()
	return -bestDirection.global_transform.basis.z.normalized()
