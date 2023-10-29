extends CharacterBody3D

var attack_counter = 1
var move_speed = 2
var gravity = 9.81
var player_node = null

func _ready():
	$AnimationPlayer.play("Zombie-library/run")
	player_node = get_tree().get_root().get_node("Main/Player")

func _physics_process(delta):
	if player_node:
		var direction_to_player = player_node.global_transform.origin - global_transform.origin
		direction_to_player.y = 0  # Zero out the vertical component to stay horizontal
		var target_rotation = atan2(direction_to_player.x, direction_to_player.z)
		global_transform.basis = Basis(Vector3.UP, target_rotation)  # Set the new rotation

		if not is_on_floor():
			velocity.y -= gravity * delta

		var direction = -(global_transform.basis.z.normalized())
		if is_on_floor():
			if direction:
				velocity.x = direction.x * -move_speed
				velocity.z = direction.z * -move_speed
			else:
				velocity.x = lerp(velocity.x, direction.x * move_speed, delta * 7.0)
				velocity.z = lerp(velocity.z, direction.z * move_speed, delta * 7.0)

		move_and_slide()
		
		if !$AnimationPlayer.is_playing():
			$AnimationPlayer.play("Zombie-library/attack" + str(attack_counter))
			attack_counter += 1
			if attack_counter > 3:
				attack_counter = 1

func _on_area_3d_body_entered(body):
	print(body.name)
	if body.name == "Player":
		print("player near")
		$AnimationPlayer.play("Zombie-library/attack1")
		attack_counter = 2

func _on_area_3d_body_exited(body):
	print(body.name)
	if body.name == "Player":
		print("player gone")
		$AnimationPlayer.play("Zombie-library/run")
