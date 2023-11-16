extends Control

@onready var health_bar := $HealthBar as ProgressBar

func _ready():
	set_max_health(100)
	update_value(100)

func set_max_health(max_health: int) -> void:
	if health_bar:
		health_bar.max_value = max_health

func update_value(current_health: int) -> void:
	if health_bar:
		health_bar.value = current_health
