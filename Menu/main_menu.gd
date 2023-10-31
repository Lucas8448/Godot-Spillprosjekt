extends Node2D

var game = "res://Main.tscn"

func _on_play_now_button_up():
	get_tree().change_scene_to_file(game)

func _on_exit_game_button_down():
	get_tree().quit()

func _on_fullscreen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
