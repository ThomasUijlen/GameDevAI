class_name DirectionRay
extends Spatial

var length = 0.0

func setDistance(amount):
	for ray in $Rays.get_children():
		ray.cast_to.z = -amount

func _physics_process(delta):
	length = 0.0

func blocked() -> bool:
	$Debugging.scale.z = max(length*2,0.0)
	for ray in $Rays.get_children():
		ray.force_raycast_update()
		if ray.is_colliding():
			$Debugging/Green.visible = false
			$Debugging/Red.visible = true
			$Debugging/Blue.visible = false
			return true
	
	$Debugging/Green.visible = true
	$Debugging/Red.visible = false
	$Debugging/Blue.visible = false
	return false

func select():
	$Debugging/Green.visible = false
	$Debugging/Red.visible = false
	$Debugging/Blue.visible = true
