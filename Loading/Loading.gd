extends Node2D

var game = preload("res://Main.tscn")

func _on_video_stream_player_finished():
	var new_instance = game.instantiate()
	get_tree().root.add_child(new_instance)
	get_tree().current_scene = new_instance
