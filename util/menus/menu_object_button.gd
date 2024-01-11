class_name MenuObjectButton extends RightMenuButton

var object: Object

signal menu_object_pressed(menu_button: MenuObjectButton, data: Object)
signal menu_object_focus_entered(menu_button: MenuObjectButton, data: Object)
signal menu_object_focus_exited(menu_button: MenuObjectButton, data: Object)

func set_object(object_to_set: Object):
	object = object_to_set

func _on_pressed():
	menu_object_pressed.emit(self, object)

func _on_focus_entered():
	menu_object_focus_entered.emit(self, object)

func _on_focus_exited():
	menu_object_focus_exited.emit(self, object)
