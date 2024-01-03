extends Node


var current_word: String = ""
var enabled: bool = false

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_M:
			current_word += "m"
		elif event.pressed and event.keycode == KEY_A:
			current_word += "a"
		elif event.pressed and event.keycode == KEY_K:
			current_word += "k"
		elif event.pressed and event.keycode == KEY_E:
			current_word += "e"
		elif event.pressed and event.keycode == KEY_I:
			current_word += "i"
		elif event.pressed and event.keycode == KEY_T:
			current_word += "t"
		elif event.pressed and event.keycode == KEY_S:
			current_word += "s"
		elif event.pressed and event.keycode == KEY_O:
			current_word += "o"
			
	if current_word == "makeitso":
		current_word = ""
		enabled = !enabled
		print("Cheat enabled: %s" % enabled)
	
	if not "makeitso".begins_with(current_word):
		current_word = ""
