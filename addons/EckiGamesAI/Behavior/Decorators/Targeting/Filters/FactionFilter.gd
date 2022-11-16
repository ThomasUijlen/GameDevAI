class_name FactionFilter, "res://addons/EckiGamesAI/Icons/Swords.png"
extends FilterAction

func filterTargets(actor, blackboard, targetList):
	var targetsToRemove = []
	
	for target in targetList:
		var ownFaction = getFaction(actor)
		var targetFaction = getFaction(target)
		
		if (!inverted and ownFaction == targetFaction) or (inverted and ownFaction != targetFaction):
			targetsToRemove.append(target)
	
	for target in targetsToRemove:
		targetList.erase(target)

func getFaction(node):
	if node.has_node("Faction"):
		return node.get_node("Faction").factionName
	return null
