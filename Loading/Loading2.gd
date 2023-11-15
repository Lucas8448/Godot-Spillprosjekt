extends Node2D

var Loader3 = "res://Loading/Loading3.tscn"

func _on_timer_timeout():
	get_tree().change_scene_to_file(Loader3)
