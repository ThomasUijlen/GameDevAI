class_name HasBBCondition, "res://addons/EckiGamesAI/Icons/QuestionMark.png"
extends BehaviorNode

export(String, MULTILINE) var expression
var parsedExpression := Expression.new()

func _ready():
	parsedExpression.parse(expression, ["blackboard"])

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	var result = parsedExpression.execute([blackboard])
	
	if result == true:
		return SUCCESS
	else:
		return FAILED
