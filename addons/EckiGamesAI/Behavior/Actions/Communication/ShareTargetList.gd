class_name ShareTargetList, "res://addons/EckiGamesAI/Icons/Communication.png"
extends TargetAction

export var groupToShare = ""
export var areaPath : NodePath

var targetList
var area : Area

func _ready():
	area = get_node_or_null(areaPath)
	assert(area != null || !enabled, "ShareTargetList requires an area")

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	var targetNew = blackboard.get("TargetNew", null, groupToShare)
	if targetNew == true: targetList = null
	
	if targetList:
		blackboard.set("TargetNew", false, groupToShare)
		return SUCCESS
	
	targetList = blackboard.get("TargetList", [], groupToShare)
	
	var nearbyCharacters = area.get_overlapping_bodies()
	for character in nearbyCharacters:
		var behaviorTree = character.get_node_or_null("BeehaveRoot")
		if behaviorTree == null: continue
		if !character.is_in_group("Faction"): continue
		if character.get_node("Faction").factionName != actor.get_node("Faction").factionName: continue
		var bb = behaviorTree.blackboard
		var shareList = bb.get("TargetList", [], targetName)
		
		for target in targetList:
			if !shareList.has(target): shareList.append(target)
		
		bb.set("TargetList", shareList, targetName)
		bb.set("TargetNew", true, targetName)
	
	return SUCCESS
