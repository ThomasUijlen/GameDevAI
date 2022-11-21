class_name TriggerCooldown, "res://addons/EckiGamesAI/Icons/Time.png"
extends BehaviorNode

export var minTime = 10.0
export var maxTime = 10.0
export var cooldownName = ""

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	blackboard.set("LastFire", Time.get_ticks_msec(), cooldownName)
	blackboard.set(cooldownName, true)
	
	blackboard.set("CooldownActive", true, cooldownName)
	blackboard.set("CurrentCooldownTime", rand_range(minTime, maxTime), cooldownName)
	
	return SUCCESS

