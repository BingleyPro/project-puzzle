extends "res://interactable/door.gd"

@export var plate_a: Node3D
@export var plate_b: Node3D
	
func interact():
	pass
	
func set_open(_value: bool) -> void:
	if not is_instance_valid(plate_a) or not is_instance_valid(plate_b):
		return
		
	var both_pressed = (plate_a.get("pressed") and plate_b.get("pressed"))
	
	if both_pressed != _is_open:
		super.set_open(both_pressed)
