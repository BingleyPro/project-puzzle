extends Control

func _ready() -> void:
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	$"CenterContainer/VBoxContainer/Level 1".pressed.connect(start_level.bind("res://scenes/levels/level1.tscn"))
	$"CenterContainer/VBoxContainer/Level 2".pressed.connect(start_level.bind("res://scenes/levels/level2.tscn"))
	$CenterContainer/VBoxContainer/Quit.pressed.connect(quit_game)

func start_level(path: String) -> void:
	get_tree().change_scene_to_file(path)
	
func quit_game() -> void:
	get_tree().quit()
