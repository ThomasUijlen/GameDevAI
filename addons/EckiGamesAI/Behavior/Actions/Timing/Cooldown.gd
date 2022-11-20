class_name Cooldown, "res://addons/EckiGamesAI/Icons/Time.png"
extends BehaviorNode

export var minTime = 10.0
export var maxTime = 10.0
export var cooldownName = ""

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	var lastFire = blackboard.get("LastFire", -1000000, cooldownName)
	blackboard.set("LastFire", lastFire, cooldownName)
	
	var currentCooldown = (OS.get_ticks_msec()-lastFire)/1000.0
	
	if currentCooldown >= blackboard.get("CurrentCooldownTime", 0, cooldownName): blackboard.set("CooldownActive", false, cooldownName)
	if blackboard.get("CooldownActive", false, cooldownName): return FAILED
	
	if blackboard.get(cooldownName, false):
		startCooldown(blackboard)
		blackboard.set(cooldownName, false)
		return FAILED
	
	return SUCCESS

func startCooldown(blackboard):
	blackboard.set("CooldownActive", true, cooldownName)
	blackboard.set("CurrentCooldownTime", rand_range(minTime, maxTime), cooldownName)
