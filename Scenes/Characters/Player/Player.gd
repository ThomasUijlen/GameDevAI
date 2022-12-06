extends CharacterController

export var maxHealth = 100.0
var health = 0.0

var respawnPosition : Vector3

var attackTimer = 0.0

func _ready():
	health = maxHealth
	respawnPosition = global_transform.origin

func attacked():
	attackTimer = 5.0

func _process(delta):
	attackTimer -= delta

func beingAttacked() -> bool:
	return attackTimer > 0

func damage(amount):
	health -= amount
	$Health.text = "Health: "+str(round(health))
	
	if health <= 0:
		$Dead.visible = true

func _input(event):
	if event.is_action_pressed("Respawn"):
		if health > 0: return
		
		global_transform.origin = respawnPosition
		health = maxHealth
		$Dead.visible = false
	
