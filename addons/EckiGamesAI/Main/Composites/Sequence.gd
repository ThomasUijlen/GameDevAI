class_name Sequence, "res://addons/EckiGamesAI/Icons/Sequence.png"
extends Composite

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	for c in get_children():
		var response = c.tick(actor, blackboard)
		
		if response != SUCCESS:
			return response
	
	return SUCCESS
