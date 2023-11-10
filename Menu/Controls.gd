extends Node2D

var menu = "res://Menu/main_menu.tscn"

func _on_back_pressed():
	get_tree().change_scene_to_file(menu)
