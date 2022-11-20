extends Spatial

const explosionScene = preload("res://Scenes/Weapons/SmokeBomb/SmokeBombExplosion.tscn")

export var curve : Curve

var t = 0.0
var throwTime = 1.0

var startPosition : Vector3
var endPosition : Vector3

func throwTo(start : Vector3, end : Vector3):
	startPosition = start
	endPosition = end

func _process(delta):
	t += delta
	if t > throwTime:
		t = throwTime
		spawnExplosion()
		queue_free()
	
	global_translation = lerp(startPosition, endPosition, t/throwTime)
	global_translation.y += curve.interpolate(t/throwTime)

func spawnExplosion():
	var explosion = explosionScene.instance()
	get_tree().current_scene.add_child(explosion)
	explosion.global_translation = global_translation
