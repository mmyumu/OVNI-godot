class_name SubMenu extends VBoxContainer

var last_focus: Button
var first_button: Button

func display():
	last_focus = null
	show()
	grab_default_focus()

func grab_default_focus():
	if first_button:
		last_focus = first_button
		first_button.grab_focus()
