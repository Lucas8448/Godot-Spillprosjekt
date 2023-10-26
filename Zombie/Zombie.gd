extends Node3D

var attack_counter = 1
var move_speed = 1
var player_node = null

func _ready():
	$AnimationPlayer.play("Zombie-library/run")
	player_node = get_tree().get_root().get_node("Main/Player")

func _process(delta):
	if player_node:
		look_at(player_node.global_transform.origin, Vector3.UP)

		var direction = global_transform.basis.z.normalized()
		global_transform.origin -= direction * move_speed * delta
		
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
