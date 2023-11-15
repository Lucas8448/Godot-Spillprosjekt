extends Node2D

var Loader2 = "res://Loading/Loading2.tscn"

func _on_timer_timeout():
	get_tree().change_scene_to_file(Loader2)
