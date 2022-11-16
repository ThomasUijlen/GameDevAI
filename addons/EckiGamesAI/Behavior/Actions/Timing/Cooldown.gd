class_name Cooldown, "res://addons/EckiGamesAI/Icons/Time.png"
extends BehaviorNode

export var minTime = 10.0
export var maxTime = 10.0
export var cooldownName = ""

var previousTick = -1
var cooldownActive = false
var currentCooldownTime = 0.0

func tick(actor, blackboard):
	if !enabled: return SUCCESS
	
	var lastFire = blackboard.get("LastFire", -1000000, cooldownName)
	blackboard.set("LastFire", lastFire, cooldownName)
	
	var currentCooldown = (OS.get_ticks_msec()-lastFire)/1000.0
	
	if currentCooldown >= currentCooldownTime: cooldownActive = false
	if cooldownActive: return FAILED
	
	if blackboard.get(cooldownName, false):
		startCooldown()
		blackboard.set(cooldownName, false)
		return FAILED
	
	return SUCCESS

func startCooldown():
	cooldownActive = true
	currentCooldownTime = rand_range(minTime, maxTime)
