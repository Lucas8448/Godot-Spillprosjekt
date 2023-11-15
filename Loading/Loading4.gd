extends Node2D

var scene_instance = get_node("res://Main.tscn").get_scene()

func _on_timer_timeout():
	get_tree().change_scene_to_file(scene_instance)
