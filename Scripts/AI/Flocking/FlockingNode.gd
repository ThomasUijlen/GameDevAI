class_name FlockingNode
extends Node

export var weight = 1.0
var ownBody : MovementController

func _ready():
	ownBody = get_parent()
