class_name MoveToTarget, "res://addons/EckiGamesAI/Icons/MoveIcon.png"
extends TargetAction

export var directionChooserPath : NodePath
export var directionWeight = 1.0
export var movementIntensity = 1.0
export var divertIfStuck = true
export var inverted = false

var directionChooser : DirectionChooser
var target = null

var avoidanceDirection = 1

func _ready():
	directionChooser = get_node(directionChooserPath)
	assert(directionChooser != null, "MoveToTarget needs a DirectionChooser")
	if rand_range(0,100) > 50: avoidanceDirection = -avoidanceDirection

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	selectTarget(actor, blackboard)
	
	if target == null: return FAILED
	
	applyDirection(actor, blackboard)
	return SUCCESS

func applyDirection(actor, blackboard):
	directionChooser.movementIntensity = movementIntensity
	
	if !walkAround(actor, blackboard):
		walkDirect(actor, blackboard)

var lastPosition = Vector3.ZERO
var timeSinceMove = 0.0
var walkAroundTimer = 0.0
func walkAround(actor, blackboard):
	if lastPosition.distance_squared_to(actor.global_transform.origin) > 1.0:
		lastPosition = actor.global_transform.origin
		timeSinceMove = 0.0
	
	if divertIfStuck: timeSinceMove += blackboard.get("delta")
	if timeSinceMove >= 2 && walkAroundTimer <= 0:
		walkAroundTimer = 3.0
		if rand_range(0,100) > 50: avoidanceDirection = -avoidanceDirection
	
	walkAroundTimer -= blackboard.get("delta")
	if walkAroundTimer > 0:
		for direction in directionChooser.directions:
			var sideways = actor.global_transform.origin.direction_to(target.global_transform.origin).rotated(actor.global_transform.basis.y, PI/2.0*avoidanceDirection)
			direction.length += (sideways.dot(-direction.global_transform.basis.z))*directionWeight
		return true
	return false

func walkDirect(actor, blackboard):
	for direction in directionChooser.directions:
		direction.length += (actor.global_transform.origin.direction_to(target.global_transform.origin).dot(-direction.global_transform.basis.z * (-1 if inverted else 1)) + 0.3)*directionWeight

func selectTarget(actor, blackboard):
	var targetList = blackboard.get("TargetList", [], targetName)
	if targetList.empty():
		target = null
		return
	
	target = targetList[0]
