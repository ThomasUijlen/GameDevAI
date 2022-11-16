class_name Selector, "res://addons/EckiGamesAI/Icons/Selector.png"
extends Composite

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	for c in get_children():
		var response = c.tick(actor, blackboard)
		
		if response != FAILURE:
			return response

	return FAILURE
