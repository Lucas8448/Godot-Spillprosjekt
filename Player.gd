class_name Player
extends CharacterBody3D

const SPEED = 10.0
const JUMP_SPEED = 5.0
const MOUSE_SENSITIVITY = 0.005

var motion = Vector3()
var camera_rotation = Vector2()

@onready var main_camera = $Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		camera_look(event.relative)

func _process(delta):
	var input_motion = Vector2()
	if Input.is_action_pressed("move_forward"):
		input_motion.y -= 1
	if Input.is_action_pressed("move_backward"):
		input_motion.y += 1
	if Input.is_action_pressed("move_left"):
		input_motion.x -= 1
	if Input.is_action_pressed("move_right"):
		input_motion.x += 1

	input_motion = input_motion.normalized()
	motion.x = input_motion.x * SPEED
	motion.z = input_motion.y * SPEED

	if Input.is_action_just_pressed("jump") and is_on_floor():
		motion.y = JUMP_SPEED
	else:
		motion.y += ProjectSettings.get_setting("physics/3d/default_gravity") * delta * 0.5 

func _physics_process(_delta):
	move_and_slide()

func camera_look(mouse_movement):
	camera_rotation += mouse_movement * MOUSE_SENSITIVITY
	camera_rotation.y = clamp(camera_rotation.y, deg_to_rad(-90), deg_to_rad(90))
	rotation_degrees.y = -rad_to_deg(camera_rotation.x)
	main_camera.rotation_degrees.x = -rad_to_deg(camera_rotation.y)
