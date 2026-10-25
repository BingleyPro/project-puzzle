extends StaticBody3D

@export var puzzle: Node

@export var highlight_mesh: MeshInstance3D
@export var highlight_material: Material

var is_lit: bool = false

func _ready() -> void:
	set_lit(false)
	
func interact() -> void:
	if puzzle != null and not is_lit:
		puzzle.call("activate", self)
		
func set_lit(value: bool) -> void:
	is_lit = value
	$OmniLight3D.visible = value
	
func highlight(enable: bool) -> void:
	if highlight_mesh != null:
		highlight_mesh.material_overlay = highlight_material 
