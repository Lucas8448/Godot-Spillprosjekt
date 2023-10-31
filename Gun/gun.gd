extends Node3D

# Define properties
var ammo_capacity = 10
var current_ammo = 10
var is_reloading = false

# Reference to the animation player
var animation_player = null

func _ready():
	# Assuming the AnimationPlayer is a child of this node.
	animation_player = $AnimationPlayer

func _input(event):
	if event.is_action_pressed("shoot"):
		shoot()
	elif event.is_action_pressed("reload"):
		reload()

# Function to handle shooting
func shoot():
	if not is_reloading and current_ammo > 0:
		# Play shooting animation
		animation_player.play("Gun/Shoot")
		# Decrease ammo count
		current_ammo -= 1
		print("Bang! Ammo left: ", current_ammo)
	else:
		print("Cannot shoot. Either reloading or out of ammo.")

# Function to handle reloading
func reload():
	if not is_reloading:
		is_reloading = true
		# Play reloading animation
		animation_player.play("Gun/Reload")
		# Reset ammo count when the animation ends
		current_ammo = ammo_capacity
		is_reloading = false
		print("Reloaded. Ammo: ", current_ammo)
