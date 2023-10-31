var speed = 800
var camera_node = null

func _ready():
	camera_node = get_tree().get_root().get_node("Main/Player/Camera3D")
	var rotation = camera_node.get_camera_projection()

func _physics_process(delta):
  linear_velocity = Vector3.RIGHT.rotated(rotation) * speed
