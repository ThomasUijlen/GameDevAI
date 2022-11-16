extends KinematicBody

export var movementSpeed = 3
export var localMovement = true

var movementDirection : Vector3 = Vector3.ZERO
var velocity = Vector3.ZERO

var movementIntensity = 1.0

func _ready():
	pass

func _physics_process(delta):
	if !is_on_floor():
		velocity.y -= 9*delta
	
	if localMovement:
		velocity.x = 0
		velocity.z = 0
		velocity += movementDirection.x*movementSpeed*movementIntensity*$Body.global_transform.basis.x
		velocity += movementDirection.z*movementSpeed*movementIntensity*$Body.global_transform.basis.z
	else:
		velocity.x = movementDirection.x*movementSpeed*movementIntensity
		velocity.z = movementDirection.z*movementSpeed*movementIntensity
	
	velocity.y = move_and_slide(velocity, Vector3.UP, true).y

func getForward() -> Vector3:
	return -$Body.global_transform.basis.z

func setIntensity(movementIntensity):
	self.movementIntensity = movementIntensity

func setDirection3D(vec : Vector3):
	movementDirection = vec.normalized()
	movementDirection.y = 0
