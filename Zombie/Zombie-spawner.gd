extends Node3D


var zombie = preload("res://Zombie/Zombie.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("new"):
		var instance = zombie.instantiate()
		instance.global_position = Vector3(global_position)
		get_parent().add_child(instance)
