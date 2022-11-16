class_name SizeFilter, "res://addons/EckiGamesAI/Icons/SizeFilter.png"
extends FilterAction

export var maxSize = 1

func filterTargets(actor, blackboard, targetList):
	while targetList.size() > maxSize:
		targetList.pop_back()
