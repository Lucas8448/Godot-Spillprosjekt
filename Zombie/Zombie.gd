extends CharacterBody3D

# Character properties
const MAX_HEALTH = 4
const MAX_FOLLOW_DISTANCE = 40
var move_speed = -4.0
var gravity = 9.81
var player_node = null
var health = MAX_HEALTH
var is_attacking = false
var player_body

var animation_handler : AnimationHandler

func _ready():
	animation_handler = AnimationHandler.new(self)
	player_node = get_tree().get_root().get_node("Main/Player")

func _physics_process(delta):
	handle_movement_and_state(delta)
	animation_handler.update()

func can_see_player() -> bool:
	var direction_to_player = player_node.global_transform.origin - global_transform.origin
	var distance_to_player = direction_to_player.length()
	return distance_to_player <= MAX_FOLLOW_DISTANCE

func handle_movement_and_state(delta):
	if health <= 0 or player_node == null:
		return

	var direction_to_player = player_node.global_transform.origin - global_transform.origin
	var distance_to_player = direction_to_player.length()
	direction_to_player.y = 0

	velocity.y -= gravity * delta

	if is_on_floor() and not is_attacking:
		if distance_to_player <= MAX_FOLLOW_DISTANCE:
			var target_rotation = atan2(direction_to_player.x, direction_to_player.z)
			global_transform.basis = Basis(Vector3.UP, lerp_angle(global_transform.basis.get_euler().y, target_rotation, delta * 5.0))
			
			var direction = global_transform.basis.z.normalized()
			velocity.x = -direction.x * move_speed
			velocity.z = -direction.z * move_speed
		else:
			velocity.x = 0
			velocity.z = 0

	move_and_slide()

func shot(damage: int):
	health -= damage
	if health <= 0:
		die()

func die():
	health = 0
	queue_free()

func _on_area_3d_body_entered(body):
	if body == player_node:
		player_body = body
		is_attacking = true

func _on_area_3d_body_exited(body):
	if body == player_node:
		is_attacking = false

class AnimationHandler:
	var owner
	var animation_player : AnimationPlayer

	func _init(p_owner):
		owner = p_owner
		animation_player = owner.get_node("AnimationPlayer")

	func update():
		determine_next_animation()

	func _animation_finished(anim_name):
		if anim_name == "Zombie-library/attack1":
			owner.is_attacking = false
			owner.player_body.recieve_damage(10)
		determine_next_animation()

	func determine_next_animation():
		if owner.health <= 0 and not animation_player.is_playing():
			play_animation("Zombie-library/die forward")
			owner.queue_free()
		elif owner.is_attacking:
			play_animation("Zombie-library/attack1")
		elif owner.is_on_floor() and owner.velocity.length() > 0:
			play_animation("Zombie-library/run")
		else:
			play_animation("Zombie-library/idle1")

	func play_animation(name):
		if animation_player.has_animation(name) and animation_player.current_animation != name:
			animation_player.play(name)

func _on_animation_player_animation_finished(anim_name):
	animation_handler._animation_finished(anim_name)
