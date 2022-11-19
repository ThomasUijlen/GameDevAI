extends CharacterController

var attackTimer = 0.0

func attacked():
	attackTimer = 10.0

func _process(delta):
	attackTimer -= delta

func beingAttacked() -> bool:
	return attackTimer <= 0
