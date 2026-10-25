extends AnimatableBody3D

@export var swing_time: float = 1.0
@export var target_door: Node3D

@export var highlight_mesh: MeshInstance3D
@export var highlight_material: Material

@onready var handle = self

var _closed_x: float
var _is_open: bool = false
var _tween: Tween

func _ready() -> void:
	_closed_x = rotation.x
	sync_to_physics = true
	
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
