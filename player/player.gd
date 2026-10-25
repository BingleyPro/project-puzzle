extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var speed_multipler = 1

@export var mouse_sensitivity: float = 0.002
@onready var head: Node3D = $Head
@onready var ray: RayCast3D = $Head/Camera3D/RayCast3D
@onready var interaction_prompt = $CanvasLayer/Control/Label
@onready var hold_point = $Head/Camera3D/HoldPoint

var focused_object = null
var held_object: RigidBody3D
var holding_object = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$Head/Camera3D/RayCast3D.add_exception(self)
	interaction_prompt.hide()
	
	platform_floor_layers = 0
	platform_wall_layers = 0
	platform_on_leave = CharacterBody3D.PLATFORM_ON_LEAVE_DO_NOTHING
	
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
				deg_to_rad(-85.0),
				deg_to_rad(85),
			)
			
	if event.is_action_pressed("interact") and not event.is_echo():
		if holding_object:
			drop_held_object()
			return
		
		ray.force_raycast_update()
		
		var target = ray.get_collider() as Node
		if target != null:
			if target.has_method("interact"):
				target.call("interact")
			
			if target.is_in_group("pickup"):
				# Pickup logic
				held_object = target
				holding_object = true
				
				held_object.sleeping = false
				held_object.add_to_group("held")
				
				# Prevent crate collding with player
				add_collision_exception_with(held_object)
				held_object.add_collision_exception_with(self)
				
	if event.is_action_pressed("restart") and not event.is_echo():
		get_tree().reload_current_scene()
			
func manage_interaction():
	ray.force_raycast_update()
	
	var target = ray.get_collider() as Node
	
	if target != null and not target.has_method("interact"):
		target = null
		
	if target != focused_object:
		if focused_object != null and is_instance_valid(focused_object):
			if focused_object.has_method("highlight"):
				focused_object.call("highlight", false)
				interaction_prompt.hide()
		
		focused_object = target
		
		if focused_object != null and is_instance_valid(focused_object):
			if focused_object.has_method("highlight"):
				focused_object.call("highlight", true)
				interaction_prompt.show()
				
func update_held_object():
	var offset = hold_point.global_position - held_object.global_position
	
	if offset.length()> 3.5:
		# If object gets too far, drop it
		drop_held_object()
		return
	
	var acceleration = (
		offset * 80 + (velocity - held_object.linear_velocity) * 18 - get_gravity() * held_object.gravity_scale
	)
	
	var force = (
		acceleration.limit_length(150) * held_object.mass
	)
	
	held_object.apply_central_force(force)
	
func drop_held_object() -> void:
	if is_instance_valid(held_object):
		remove_collision_exception_with(held_object)
		held_object.remove_collision_exception_with(self)
		held_object.remove_from_group("held")
		
		held_object = null
		holding_object = false

func _physics_process(delta):
	speed_multipler = 1
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle sprinting
	if Input.is_action_pressed("sprint") and is_on_floor():
			speed_multipler = 1.4

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
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
		
	move_and_slide()
	
	# Handle held object
	if holding_object:
		update_held_object()
		
	# Check any interactable objects
	manage_interaction()
