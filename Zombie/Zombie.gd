extends Node3D

var player_nearby = false
var attack_counter = 1

func _ready():
	$AnimationPlayer.play("Zombie-library/run")

func _process(delta):
	if player_nearby:
		if !$AnimationPlayer.is_playing():
			$AnimationPlayer.play("Zombie-library/attack" + str(attack_counter))
			attack_counter += 1
			if attack_counter > 3:
				attack_counter = 1

func _on_area_3d_body_entered(body):
	print(body.name)
	if body.name == "Player":
		print("player near")
		player_nearby = true
		$AnimationPlayer.play("Zombie-library/attack1")
		attack_counter = 2

func _on_area_3d_body_exited(body):
	print(body.name)
	if body.name == "Player":
		print("player gone")
		player_nearby = false
		$AnimationPlayer.play("Zombie-library/run")
