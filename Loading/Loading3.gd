extends Node2D

var Loader4 = "res://Loading/Loading4.tscn"

func _on_timer_timeout():
	get_tree().change_scene_to_file(Loader4)
