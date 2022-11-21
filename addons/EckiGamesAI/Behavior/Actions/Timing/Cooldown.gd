class_name Cooldown, "res://addons/EckiGamesAI/Icons/Time.png"
extends BehaviorNode

export var cooldownName = ""

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	var lastFire = blackboard.get("LastFire", -1000000, cooldownName)
	blackboard.set("LastFire", lastFire, cooldownName)
	
	var currentCooldown = (OS.get_ticks_msec()-lastFire)/1000.0
	
	if currentCooldown >= blackboard.get("CurrentCooldownTime", 0, cooldownName): blackboard.set("CooldownActive", false, cooldownName)
	if blackboard.get("CooldownActive", false, cooldownName): return FAILED
	
	return SUCCESS
