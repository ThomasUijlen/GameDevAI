class_name SetRandomTarget, "res://addons/EckiGamesAI/Icons/Random.png"
extends TargetAction

const movePointScene = preload("res://addons/EckiGamesAI/Behavior/Actions/Movement/MovePoint/MovePoint.tscn")

enum DISTANCE_MODE {
	CURRENT_POSITION,
	ORIGIN
}

export(DISTANCE_MODE) var distanceMode = DISTANCE_MODE.CURRENT_POSITION
export var minDistance = 0.0
export var maxDistance = 20.0
export var originRadius = 50.0

var previousMovePoint = null
var targetList = []

var origin
func _ready():
	if distanceMode == DISTANCE_MODE.ORIGIN:
		origin = Spatial.new()
		get_tree().current_scene.call_deferred("add_child", origin)

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	if origin and origin.translation == Vector3.ZERO:
		origin.global_transform.origin = actor.global_transform.origin
	
	if !targetList.empty():
		blackboard.set("TargetNew", false, targetName)
		return SUCCESS
	
	targetList = blackboard.get("TargetList", targetList, targetList)
	blackboard.set("TargetList", targetList, targetName)
	
	setRandomTarget(actor, blackboard)
	
	blackboard.set("TargetNew", true, targetName)
	return SUCCESS

func setRandomTarget(actor, blackboard):
	if previousMovePoint and is_instance_valid(previousMovePoint):
		previousMovePoint.queue_free()
	
	var movePoint = movePointScene.instance()
	previousMovePoint = movePoint
	get_tree().current_scene.add_child(movePoint)
	
	var globalTranslation = actor.global_transform.origin + Vector3(rand_range(-maxDistance, maxDistance), rand_range(-maxDistance, maxDistance), rand_range(-maxDistance, maxDistance))
	var localTranslation = actor.to_local(globalTranslation)
	localTranslation.y = 0.0
	
	if localTranslation.length() < minDistance: localTranslation = localTranslation.normalized()*minDistance
	
	movePoint.global_transform.origin = actor.to_global(localTranslation)
	
	if distanceMode == DISTANCE_MODE.ORIGIN:
		var localToOrigin = origin.to_local(movePoint.global_transform.origin)
		if localToOrigin.length() > originRadius:
			localToOrigin = localToOrigin.normalized()*originRadius
			movePoint.global_transform.origin = origin.to_global(localToOrigin)
	
	targetList.append(movePoint)

func _exit_tree():
	if previousMovePoint and is_instance_valid(previousMovePoint):
		previousMovePoint.queue_free()
	
	if origin:
		origin.queue_free()
