extends "res://interactable/door.gd"


@export var pressure_plate: Node3D
@export var unlock_lever: Node3D

var permanently_unlocked = false

func interact():
	pass
	
func set_open(_value: bool):
	update_inputs()
	
func _physics_process(_delta):
	update_inputs()
	
func update_inputs():
	if is_instance_valid(unlock_lever):
		if unlock_lever.call("is_active"):
			permanently_unlocked = true
			
	var plate_pressed = (is_instance_valid(pressure_plate) and pressure_plate.get("pressed"))
	
	var should_open = plate_pressed or permanently_unlocked
	
	if should_open != _is_open:
		super.set_open(should_open)
