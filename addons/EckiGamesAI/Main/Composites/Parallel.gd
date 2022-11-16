class_name Parallel, "res://addons/EckiGamesAI/Icons/Parallel.png"
extends Composite

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	for c in get_children():
		c.tick(actor, blackboard)

	return SUCCESS
