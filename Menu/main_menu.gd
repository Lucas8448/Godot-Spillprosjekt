extends Node2D

var loader1 = "res://Loading/Loading1.tscn"
var controls = "res://Menu/Controls.tscn"

func _on_play_now_button_up():
	get_tree().change_scene_to_file(loader1)

func _on_exit_game_button_down():
	get_tree().quit()

func _on_fullscreen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_controls_pressed():
	get_tree().change_scene_to_file(controls)
