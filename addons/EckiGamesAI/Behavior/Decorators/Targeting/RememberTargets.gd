class_name RememberTargets, "res://addons/EckiGamesAI/Icons/Memory.png"
extends TargetAction

export var groupToRemember = ""
export var memoryLength = 10.0
var memory : Dictionary

var memoryLengthMSEC : int

func _ready():
	memoryLengthMSEC = round(memoryLength*1000)

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	var targetNew = blackboard.get("TargetNew", null, groupToRemember)
	if targetNew == null: return FAILED
	if targetNew == false: return SUCCESS
	
	var targetList = blackboard.get("TargetList", null, groupToRemember)
	if targetList == null: return FAILED
	
	if memory == null:
		memory = blackboard.get("Memory", {}, targetName)
		blackboard.set("Memory", memory.keys(), targetName)
	
	expireOldTargets()
	
	var currentTime = OS.get_ticks_msec()
	for target in targetList:
		memory[target] = currentTime
	
	blackboard.set("TargetList", memory.keys(), targetName)
	
	return SUCCESS

func expireOldTargets():
	var currentTime = OS.get_ticks_msec()
	var oldTargets = []
	for target in memory:
		var time = memory[target]
		
		if currentTime - time > memoryLengthMSEC:
			oldTargets.append(target)
	
	for target in oldTargets:
		memory.erase(target)
