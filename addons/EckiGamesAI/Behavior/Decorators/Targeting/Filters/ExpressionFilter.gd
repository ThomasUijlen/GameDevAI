class_name ExpressionFilter, "res://addons/EckiGamesAI/Icons/CogFilter.png"
extends FilterAction

export(String, MULTILINE) var expression

var parsedExpression := Expression.new()

func _ready():
	parsedExpression.parse(self.expression, ["target", "actor", "blackboard"])

func filterTargets(actor, blackboard, targetList):
	var targetsToRemove = []
	
	for target in targetList:
		var targetPosition = target.global_transform.origin
		if (!inverted and !checkExpression(actor, blackboard, target)) or (inverted and checkExpression(actor, blackboard, target)):
			targetsToRemove.append(target)
	
	for target in targetsToRemove:
		targetList.erase(target)

func checkExpression(actor, blackboard, target) -> bool:
	return parsedExpression.execute([target,actor,blackboard])
