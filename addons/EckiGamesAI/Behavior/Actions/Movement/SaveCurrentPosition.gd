class_name SaveCurrentPosition, "res://addons/EckiGamesAI/Icons/SpecificDecorator.png"
extends TargetAction

const movePointScene = preload("res://addons/EckiGamesAI/Behavior/Actions/Movement/MovePoint/MovePoint.tscn")

var previousMovePoint = null
var targetList = []

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
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
	
	var globalTranslation = actor.global_transform.origin
	var localTranslation = actor.to_local(globalTranslation)
	localTranslation.y = 0.0
	
	movePoint.global_transform.origin = actor.to_global(localTranslation)
	targetList.append(movePoint)

func _exit_tree():
	if previousMovePoint and is_instance_valid(previousMovePoint):
		previousMovePoint.queue_free()
