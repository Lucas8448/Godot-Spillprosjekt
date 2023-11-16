extends CharacterBody3D

var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const JUMP_VELOCITY = 4.8
const SENSITIVITY = 0.004

# Health properties
var max_health = 100
var health = max_health

# fov variables
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5
var camera_rotation = Vector2()

var gravity = 9.8

@onready var camera = $Camera3D
@onready var health_bar = $Camera3D/Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		camera_rotation.x += event.relative.x * SENSITIVITY
		camera_rotation.y += event.relative.y * SENSITIVITY
		camera_rotation.y = clamp(camera_rotation.y, -PI/2, PI/2)
		camera.transform.basis = Basis()
		camera.rotate_object_local(Vector3.UP, -camera_rotation.x)
		camera.rotate_object_local(Vector3.RIGHT, -camera_rotation.y)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	speed = SPRINT_SPEED if Input.is_action_pressed("sprint") else WALK_SPEED

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (camera.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if is_on_floor():
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)

	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)

	move_and_slide()

func receive_damage(amount: int):
	health -= amount
	health = max(health, 0)  # Ensure health doesn't go below 0
	health_bar.update_value(health)
	if health <= 0:
		die()

func die():
	get_tree().change_scene_to_file("res://Dead/Death.tscn")
