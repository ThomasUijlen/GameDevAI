class_name TriggerCooldown, "res://addons/EckiGamesAI/Icons/Time.png"
extends BehaviorNode

export var cooldownName = ""

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	blackboard.set("LastFire", Time.get_ticks_msec(), cooldownName)
	blackboard.set(cooldownName, true)
	return SUCCESS

