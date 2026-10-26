extends "res://interactable/lever.gd"

@export var target_firepot: Node3D
	
func interact() -> void:
	set_open(not _is_open)
	
func highlight(enabled: bool) -> void:
	if highlight_mesh != null:
		highlight_mesh.material_overlay = (
			highlight_material if enabled else null
		)
	
func set_open(value: bool) -> void:
	_is_open = value
	
	if is_instance_valid(target_door):
		target_door.call("set_open", value)
	
	var target_x = _closed_x
	if _is_open:
		target_x += deg_to_rad(90)
		
	if _tween != null and _tween.is_valid():
		_tween.kill()

	_tween = create_tween()
	_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	_tween.set_trans(Tween.TRANS_SINE)
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.tween_property(
		self, "rotation:x", target_x, maxf(swing_time, 0.01)
	)
	
	if is_instance_valid(target_firepot):
		target_firepot.call("set_lit", true)
	
func is_active() -> bool:
	return _is_open
