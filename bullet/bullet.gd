extends Node3D
class_name MyBullet

var speed = -800.0
var lifetime = 5.0  # seconds
var direction = Vector3.ZERO
var damage = 10  # Set the damage value for the bullet

func start(_direction: Vector3):
	print("Bullet moving", _direction)
	direction = _direction.normalized()

func _process(delta):
	translate(direction * speed * delta)

func _on_Bullet_body_entered(body: Node):
	queue_free()

func _on_timer_timeout():
	queue_free()
