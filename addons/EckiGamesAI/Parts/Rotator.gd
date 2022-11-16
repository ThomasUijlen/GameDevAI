class_name Rotator
extends Spatial

export var nodeToRotate : NodePath
export var rotationSpeed = 1.0

var lookPoint = null

var node : Spatial
var ignoreY = true

func _ready():
	node = get_node(nodeToRotate)

func _physics_process(delta):
	if lookPoint:
		look_at(lookPoint, get_parent().global_transform.basis.y)
		
		if ignoreY:
			rotation.x = 0
			rotation.z = 0
		
		node.global_transform = node.global_transform.interpolate_with(global_transform, clamp(delta*rotationSpeed,0,1))
		node.scale = Vector3.ONE
		lookPoint = null

func lookAtPoint(point, ignoreY = true):
	lookPoint = point
	self.ignoreY = ignoreY
