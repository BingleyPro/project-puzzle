extends MeshInstance3D

var is_lit: bool = false

func _ready() -> void:
	set_lit(false)
		
func set_lit(value: bool) -> void:
	is_lit = value
	$OmniLight3D.visible = value
	$Flames.emitting = value
	$Flames.visible = value
