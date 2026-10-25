extends RigidBody3D

@export var can_pickup = true
@export var carry_speed: float = 20.0
@export var highlight_mesh: MeshInstance3D
@export var highlight_material: Material

@onready var collision_shape: CollisionShape3D = $CollisionShape3D

var carried = false
var holder: PhysicsBody3D
var previous_freeze = false
var previous_freeze_mode = FREEZE_MODE_STATIC

func _ready() -> void:
	pass
	
func interact() -> void:
	pass
	
func highlight(enabled: bool) -> void:
	if highlight_mesh != null:
		highlight_mesh.material_overlay = (
			highlight_material if enabled else null
		)
	
func pickup():
	pass
