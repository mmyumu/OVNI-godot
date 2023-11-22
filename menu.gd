extends CanvasLayer


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$StartButton.grab_focus()

func _process(delta):
	pass

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://global/main.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
