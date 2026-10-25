extends Node3D

@onready var detector = $Detector
@export var target_door: Node3D

var pressed: bool = false
var pressed_now = false

func _physics_process(delta):
	pressed_now = false
	
	for body in detector.get_overlapping_bodies():
		if body.is_in_group("plate_detection"):
			pressed_now = true
			break

	if pressed_now != pressed:
		pressed = pressed_now
		
		if is_instance_valid(target_door):
			target_door.call("set_open", pressed)
