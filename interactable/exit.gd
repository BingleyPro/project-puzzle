extends Area3D

@onready var completion_panel: Panel = $CanvasLayer/CompletionPanel

var completed = false

func _ready() -> void:
	completion_panel.hide()
	
	$CanvasLayer/CompletionPanel/CenterContainer/VBoxContainer/Button.pressed.connect(_on_menu_pressed)
	
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if completed or not body.is_in_group("player"):
		return
		
	completed = true
	completion_panel.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	
func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
