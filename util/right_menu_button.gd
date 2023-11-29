class_name RightMenuButton extends Button

signal menu_button_pressed(button: RightMenuButton)

func _on_pressed():
	menu_button_pressed.emit(self)
