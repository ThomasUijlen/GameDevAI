class_name LookAtTarget, "res://addons/EckiGamesAI/Icons/EyeAction.png"
extends TargetAction

export var rotatorPath : NodePath
export var ignoreY = true

var rotator : Rotator
var target = null

func _ready():
	rotator = get_node(rotatorPath)
	assert(rotator != null, "LookAtTarget needs Rotator")

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	selectTarget(actor, blackboard)
	if target == null: return FAILED
	lookAt(actor, blackboard)
	return SUCCESS

func lookAt(actor, blackboard):
	rotator.lookAtPoint(target.global_transform.origin, ignoreY)

func selectTarget(actor, blackboard):
	var targetList = blackboard.get("TargetList", [], targetName)
	if targetList.empty():
		target = null
		return
	
	target = targetList[0]
