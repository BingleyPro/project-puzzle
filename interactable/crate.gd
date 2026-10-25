extends RigidBody3D

@export var can_pickup = true

@export var highlight_mesh: MeshInstance3D
@export var highlight_material: Material

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
