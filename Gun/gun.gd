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
	print("input")
	if event.is_action_pressed("shoot"):
		print("SHOOT")
		shoot()
	elif event.is_action_pressed("reload"):
		reload()

# Function to handle shooting
func shoot():
	if not is_reloading and current_ammo > 0:
		# Play shooting animation
		animation_player.play("CarryPistol_Rig | FireCycle")
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
		animation_player.play("Reload")
		# Reset ammo count when the animation ends
		animation_player.connect("animation_finished", self, "_on_reload_animation_finished")

# Callback for when the reload animation finishes
func _on_reload_animation_finished(animation_name):
	if animation_name == "Reload":
		current_ammo = ammo_capacity
		is_reloading = false
		print("Reloaded. Ammo: ", current_ammo)
