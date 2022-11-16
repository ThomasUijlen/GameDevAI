extends Spatial

var crumbList : Array

func expire():
	crumbList.erase(self)
	queue_free()
