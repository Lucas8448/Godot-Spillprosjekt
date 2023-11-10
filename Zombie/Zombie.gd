extends CharacterBody3D

const MAX_HEALTH = 4  # Maximum health of the zombie

var attack_counter = 1
var move_speed = -2.0
var gravity = 9.81
var player_node = null
var is_player_near = false
var health = MAX_HEALTH  # Current health of the zombie

func _ready():
	$AnimationPlayer.play("Zombie-library/run")
	player_node = get_tree().get_root().get_node("Main/Player")

func _physics_process(delta):
	if health > 0:  # Only process movement if the zombie is alive
		if player_node:
			var direction_to_player = player_node.global_transform.origin - global_transform.origin
			direction_to_player.y = 0
			var target_rotation = atan2(direction_to_player.x, direction_to_player.z)
			global_transform.basis = Basis(Vector3.UP, lerp_angle(global_transform.basis.get_euler().y, target_rotation, delta * 5.0))

			if not is_on_floor():
				velocity.y -= gravity * delta

			var direction = global_transform.basis.z.normalized()
			if is_on_floor():
				velocity.x = -direction.x * move_speed
				velocity.z = -direction.z * move_speed
			else:
				velocity.x = 0
				velocity.z = 0

			move_and_slide()

	handle_animation()

func handle_animation():
	if is_on_floor():
		if is_player_near and health > 0:
			var animation_name = "Zombie-library/attack" + str(attack_counter)
			if $AnimationPlayer.current_animation != animation_name:
				$AnimationPlayer.play(animation_name)
				attack_counter = (attack_counter % 3) + 1
		elif health > 0:
			if $AnimationPlayer.current_animation != "Zombie-library/run":
				$AnimationPlayer.play("Zombie-library/run")
		else:
			if $AnimationPlayer.current_animation != "Zombie-library/die forward":
				$AnimationPlayer.play("Zombie-library/die forward")
	else:
		if $AnimationPlayer.current_animation != "Zombie-library/idle":
			$AnimationPlayer.play("Zombie-library/idle")

func shot(damage: int):
	health -= damage
	if health <= 0:
		die()
	else:
		$AnimationPlayer.play("Zombie-library/hit")

func die():
	if $AnimationPlayer.current_animation != "Zombie-library/die forward":
		$AnimationPlayer.play("Zombie-library/die forward")
		await $AnimationPlayer.get_tree().create_timer($AnimationPlayer.current_animation_length).timeout
		queue_free()
	
func _on_body_entered(body):
	if body == player_node:
		is_player_near = true

func _on_body_exited(body):
	if body == player_node:
		is_player_near = false
