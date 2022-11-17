extends Spatial

var crumbSpawner

func expire():
	if is_instance_valid(crumbSpawner):
		crumbSpawner.deleteCrumb(self)
	queue_free()
