extends Node2D

var menu = "res://Menu/main_menu.tscn"

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_timer_timeout():
	get_tree().change_scene_to_file(menu)
