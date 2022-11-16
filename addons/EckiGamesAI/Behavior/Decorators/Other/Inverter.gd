class_name Inverter, "res://addons/EckiGamesAI/Icons/Inverter.png"
extends BehaviorNode

func tick(actor, blackboard):
	var result = get_child(0).tick(actor, blackboard)
	
	if !enabled: return result
	
	if result == SUCCESS:
		return FAILED
	else:
		return SUCCESS
