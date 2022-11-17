extends Spatial

func _ready():
	pass

func equip(weapon : Area):
	weapon.monitorable = false
	weapon.get_parent().remove_child(weapon)
	$Hand.add_child(weapon)
	weapon.translation = Vector3.ZERO
	weapon.rotation = Vector3.ZERO

func attack():
	if $AnimationPlayer.is_playing(): return
	$AnimationPlayer.play("Slash")
