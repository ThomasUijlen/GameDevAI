extends Spatial

func _ready():
	process_priority = 1

var t = rand_range(0,0.5)
func _physics_process(delta):
	t += delta
	if t > 0.5:
		t = 0.0
		var direction = $DirectionChooser.getDirection()
		get_parent().setDirection3D(direction)
		get_parent().setIntensity($DirectionChooser.movementIntensity)
