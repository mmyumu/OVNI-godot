class_name MenuDataButton extends Button

var data: Resource

signal menu_data_pressed(menu_button: MenuDataButton, data: Resource)
signal menu_data_focus_entered(menu_button: MenuDataButton, data: Resource)
signal menu_data_focus_exited(menu_button: MenuDataButton, data: Resource)

func set_data(data_to_set: Resource):
	data = data_to_set

func _on_pressed():
	menu_data_pressed.emit(self, data)

func _on_focus_entered():
	menu_data_focus_entered.emit(self, data)

func _on_focus_exited():
	menu_data_focus_exited.emit(self, data)
