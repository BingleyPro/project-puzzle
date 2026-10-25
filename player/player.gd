extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var speed_multipler = 1

@export var mouse_sensitivity: float = 0.002
@onready var head: Node3D = $Head
@onready var ray: RayCast3D = $Head/Camera3D/RayCast3D

var focused_object = null

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$Head/Camera3D/RayCast3D.add_exception(self)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	elif event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			# Show mouse again
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			rotate_y(-event.screen_relative.x * mouse_sensitivity)
			head.rotate_x(-event.screen_relative.y * mouse_sensitivity)
			head.rotation.x = clampf(
				head.rotation.x,
				-85,
				85,
			)
			
	if Input.is_action_just_pressed("interact"):
		ray.force_raycast_update()
		
		var target = ray.get_collider() as Node
		if target != null and target.has_method("interact"):
			target.call("interact")
			
func manage_interaction():
	ray.force_raycast_update()
	
	var target = ray.get_collider() as Node
	
	if target != null and not target.has_method("interact"):
		target = null
		
	if target != focused_object:
		if focused_object != null:
			focused_object.call("highlight", false)
		
		focused_object = target
		
		if focused_object != null:
			focused_object.call("highlight", true)

func _physics_process(delta):
	speed_multipler = 1
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Sprint
	if Input.is_action_pressed("sprint") and is_on_floor():
			speed_multipler = 1.4

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * speed_multipler
		velocity.z = direction.z * SPEED * speed_multipler
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * speed_multipler)
		velocity.z = move_toward(velocity.z, 0, SPEED * speed_multipler)
		
	# Check any interactable objects
	manage_interaction()

	move_and_slide()
