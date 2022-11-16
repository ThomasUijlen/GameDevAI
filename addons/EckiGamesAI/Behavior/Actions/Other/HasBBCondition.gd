class_name HasBBCondition, "res://addons/EckiGamesAI/Icons/QuestionMark.png"
extends BehaviorNode

export(String, MULTILINE) var expression

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	var expression := Expression.new()
	
	var result = expression.execute([blackboard])
	
	if result == true:
		return SUCCESS
	else:
		return FAILED
