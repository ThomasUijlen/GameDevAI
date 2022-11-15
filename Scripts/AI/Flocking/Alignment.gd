extends FlockingNode

func _physics_process(delta):
	var boids : Array = get_tree().get_nodes_in_group("Boid")
	
	var averageDirection = Vector3.ZERO
	
	for _boid in boids:
		var boid : MovementController = _boid
		averageDirection += boid.movementDirection
	
	ownBody.flockingDirection += averageDirection.normalized()*weight
