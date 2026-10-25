extends Node

@export var correct_order: Array[Node3D] = []
@export var door: Node3D

var progress: int = 0
var solved: bool = false

func activate(brazier: Node3D) -> void:
	if solved or correct_order.is_empty():
		return
	
	if brazier != correct_order[progress]:
		reset_puzzle()
		return
		
	brazier.call("set_lit", true)
	progress += 1

	if progress == correct_order.size():
		solved = true
		
		if door != null:
			door.call("set_open", true)

func reset_puzzle() -> void:
	progress = 0
	
	for brazier in correct_order:
		brazier.call("set_lit", false)
