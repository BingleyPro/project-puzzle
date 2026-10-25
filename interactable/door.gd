extends AnimatableBody3D

@export var openable: bool = true
@export var open_angle: float = 90.0
@export var swing_time: float = 1.0

@export var highlight_mesh: MeshInstance3D
@export var highlight_material: Material

var _closed_y: float
var _is_open: bool = false
var _tween: Tween

func _ready() -> void:
	_closed_y = rotation.y
	sync_to_physics = true
	
func interact():
	if openable:
		set_open(not _is_open)
	
func highlight(enabled: bool) -> void:
	if highlight_mesh != null:
		highlight_mesh.material_overlay = (
			highlight_material if enabled else null
		)
	
func set_open(value: bool) -> void:
	_is_open = value
	var target_y = _closed_y
	if _is_open:
		target_y += deg_to_rad(open_angle)

	if _tween != null and _tween.is_valid():
		_tween.kill()

	_tween = create_tween()
	_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	_tween.set_trans(Tween.TRANS_SINE)
	_tween.set_ease(Tween.EASE_IN_OUT)
	
	# Fix door 360deg issue
	var shortest_target_y = (
		rotation.y + angle_difference(rotation.y, target_y)
	)
	
	_tween.tween_property(
		self, "rotation:y", shortest_target_y, maxf(swing_time, 0.01)
	)
