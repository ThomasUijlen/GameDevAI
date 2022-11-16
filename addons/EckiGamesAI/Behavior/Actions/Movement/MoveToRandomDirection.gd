class_name MoveToRandomDirection, "res://addons/EckiGamesAI/Icons/MoveIcon.png"
extends BehaviorNode

export var directionChooserPath : NodePath
export var directionWeight = 1.0
export var directionChangeSpeed = 1.0

var directionChooser : DirectionChooser

var moveDirection = Vector3.ZERO

var noise : OpenSimplexNoise = OpenSimplexNoise.new()

func _ready():
	directionChooser = get_node(directionChooserPath)
	noise.seed = round(rand_range(0,100000))
	
	var r = rand_range(0,100)
	if r < 25:
		moveDirection = Vector3.FORWARD
	elif r < 50:
		moveDirection = Vector3.BACK
	elif r < 75:
		moveDirection = Vector3.LEFT
	else:
		moveDirection = Vector3.RIGHT

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	applyDirection(actor, blackboard)
	return SUCCESS

func applyDirection(actor, blackboard):
	walkDirect(actor, blackboard)

var t = 0.0
func walkDirect(actor, blackboard):
	t += blackboard.get("delta")*directionChangeSpeed
	var n = noise.get_noise_1d(t)
	moveDirection = moveDirection.rotated(Vector3.UP, n*blackboard.get("delta"))
	
	var globalDirection = Vector3.ZERO
	globalDirection += actor.global_transform.basis.x * moveDirection.x
	globalDirection += actor.global_transform.basis.y * moveDirection.y
	globalDirection += actor.global_transform.basis.z * moveDirection.z
	globalDirection = globalDirection.normalized()
	
	for direction in directionChooser.directions:
		direction.length += (globalDirection.dot(-direction.global_transform.basis.z) + 0.3)*directionWeight
