class_name MovementController
extends Spatial

export var movementSpeed = 2

var flockingDirection : Vector3 = Vector3.ZERO
var movementDirection : Vector3 = Vector3.FORWARD

func _ready():
	movementDirection = Vector3(rand_range(-1,1),rand_range(-1,1),rand_range(-1,1)).normalized()

func _physics_process(delta):
	movementDirection = lerp(movementDirection,flockingDirection.normalized(),delta)
	flockingDirection = Vector3.ZERO
	
	global_transform.origin += movementDirection * movementSpeed * delta
	look_at(global_transform.origin + movementDirection, Vector3.UP)
