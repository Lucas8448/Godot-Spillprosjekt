extends Node2D

var loader_path = "res://Loading/Loading.tscn"
var controls = "res://Menu/Controls.tscn"
var loading_thread = Thread.new()
var loader_instance = null
var path_to_load = ""  # Member variable for the path

func _ready():
	path_to_load = loader_path  # Set the path
	var callable = Callable(self, "_load_loader_scene_in_background")  # Create a Callable
	loading_thread.start(callable)  # Start the thread with the Callable

func _load_loader_scene_in_background():
	var scene = load(path_to_load)  # Use the member variable for the path
	loader_instance = scene.instantiate()

func _on_play_now_button_up():
	if loader_instance:
		var current_scene = get_tree().current_scene
		if current_scene:
			current_scene.queue_free()

		get_tree().root.add_child(loader_instance)
		get_tree().current_scene = loader_instance
	else:
		print("Loader scene is still loading.")

func _exit_tree():
	loading_thread.wait_to_finish()

func _on_exit_game_button_down():
	get_tree().quit()

func _on_fullscreen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_controls_pressed():
	get_tree().change_scene_to_file(controls)
