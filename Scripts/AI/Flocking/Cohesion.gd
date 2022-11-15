extends FlockingNode

export var minDistance : float = 1.0
export var maxDistance : float = 2.0

func _physics_process(delta):
	var boids : Array = get_tree().get_nodes_in_group("Boid")
	
	var averageDirection = Vector3.ZERO
	
	for _boid in boids:
		var boid : MovementController = _boid
		
		var distance = ownBody.global_translation.distance_to(boid.global_translation)
		var modifier = clamp(range_lerp(distance, minDistance, maxDistance, 0.0, 1.0), 0.0, 1.0)
		averageDirection += ownBody.global_translation.direction_to(boid.global_translation)*modifier
	
	ownBody.flockingDirection += averageDirection.normalized()*weight
