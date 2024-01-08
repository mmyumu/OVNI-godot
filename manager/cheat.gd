extends Node


var current_word: String = ""
var enabled: bool = false

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_M:
			current_word += "m"
		elif event.keycode == KEY_A:
			current_word += "a"
		elif event.keycode == KEY_K:
			current_word += "k"
		elif event.keycode == KEY_E:
			current_word += "e"
		elif event.keycode == KEY_I:
			current_word += "i"
		elif event.keycode == KEY_T:
			current_word += "t"
		elif event.keycode == KEY_S:
			current_word += "s"
		elif event.keycode == KEY_O:
			current_word += "o"
		
		if enabled:
			if event.keycode == KEY_SEMICOLON:
				Saver.data.money += 100000
			elif event.keycode == KEY_F:
				forward_time()
			
	if current_word == "makeitso":
		current_word = ""
		enabled = !enabled
		print("Cheat enabled: %s" % enabled)
	
	if not "makeitso".begins_with(current_word):
		current_word = ""

func forward_time():
	Datetimer.spend(3600)
