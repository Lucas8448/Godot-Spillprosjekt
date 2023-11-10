extends Node3D

var ammo_capacity = 10
var current_ammo = 10
var is_reloading = false

var bullet_scene : PackedScene = preload("res://bullet/bullet.tscn")
var speed = 800
var camera_node : Camera3D = null
@onready var raycast = $RayCast3D2

func _ready():
	camera_node = get_tree().get_root().get_node("Main/Player/Camera3D")

func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		shoot()
	elif event.is_action_pressed("reload"):
		reload()

func shoot():
	if not is_reloading and current_ammo > 0:
		current_ammo -= 1  # Deduct ammo first to prevent multiple shots due to input.
		
		if raycast.is_colliding():
			var target = raycast.get_collider()
			if target != null:
				if target.is_in_group("Enemy") and target.has_method("shot"):
					target.shot(1)

		# We should spawn the bullet at the gun's position and in the direction of the gun's forward vector.
		var spawn_position = global_transform.origin  # Assuming the gun script is on the gun node.
		var direction = -global_transform.basis.z.normalized()  # This is the gun's forward direction.
		
		instantiate_bullet(spawn_position, direction)
		$AnimationPlayer.play("Gun/Shoot")
		
		
func reload():
	if not is_reloading:
		is_reloading = true
		$AnimationPlayer.play("Gun/Reload")
		current_ammo = ammo_capacity
		is_reloading = false

func instantiate_bullet(spawn_position, direction):
	var bullet_instance = MyBullet.new()
	bullet_instance.global_transform.origin = spawn_position
	get_parent().add_child(bullet_instance)
	bullet_instance.start(direction)
