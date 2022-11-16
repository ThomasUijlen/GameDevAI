class_name GroupWithTargets, "res://addons/EckiGamesAI/Icons/MoveIcon.png"
extends TargetAction

export var directionChooserPath : NodePath
export var directionWeight = 1.0
export var inverted = false
export var minDistance = 5
export var maxDistance = 10

var directionChooser : DirectionChooser

func _ready():
	directionChooser = get_node(directionChooserPath)

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	applyDirection(actor, blackboard)
	return SUCCESS

var directions = []
func applyDirection(actor, blackboard):
	var targetList = blackboard.get("TargetList", [], targetName)
	
	directions.clear()
	for direction in directionChooser.directions: directions.append(0.0)
	
	for target in targetList:
		walkDirect(actor, blackboard, target)
	
	var longestDistance = 0.0
	for direction in directions:
		if direction == 0: continue
		if direction > longestDistance:
			longestDistance = direction
	
	if longestDistance == 0: return
	
	var i := 0
	for direction in directionChooser.directions:
		direction.length += (directions[i]/longestDistance)*directionWeight
		i += 1


func walkDirect(actor, blackboard, target):
	var i := 0
	for direction in directionChooser.directions:
		var d = clamp(range_lerp(actor.global_transform.origin.distance_to(target.global_transform.origin), minDistance, maxDistance, 0.0, 1.0), 0.0, 1.0)
		
		directions[i] += (actor.global_transform.origin.direction_to(target.global_transform.origin).dot(-direction.global_transform.basis.z * (-1 if inverted else 1)) + 0.3)*d
		i += 1
