class_name BehaviorTree, "res://addons/EckiGamesAI/Icons/Tree.png"
extends BehaviorRoot

const Blackboard = preload("../blackboard.gd")

enum {
	SUCCES,
	FAILURE
}

enum ProcessMode {
	PHYSICS_PROCESS,
	IDLE,
	MANUAL
}

export (ProcessMode) var process_mode = ProcessMode.PHYSICS_PROCESS setget set_process_mode
export (bool) var enabled = true

export (NodePath) var actor_node_path

var actor : Node

onready var blackboard = Blackboard.new()

var i = 0

func _ready():
	if self.get_child_count() != 1:
		disable()
		return

	actor = get_parent()
	if actor_node_path:
		actor = get_node(actor_node_path)

	set_process_mode(self.process_mode)

func _process(delta):
	tick(delta)
  
func _physics_process(delta):
	tick(delta)

func tick(delta):
	blackboard.set("delta", delta)
	
	i += 1
	blackboard.set("i", i)
	
	self.get_child(0).tick(actor, blackboard)

func enable():
	self.enabled = true
	set_process_mode(self.process_mode)

func disable():
	self.enabled = false
	set_process(self.enabled)
	set_physics_process(self.enabled)

func set_process_mode(value):
	process_mode = value
	set_process(process_mode == ProcessMode.IDLE)
	set_physics_process(process_mode == ProcessMode.PHYSICS_PROCESS)
