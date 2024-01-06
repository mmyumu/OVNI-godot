class_name MenuBaseButton extends Button

var base

signal menu_base_pressed(menu_button: MenuBaseButton, base: Base)
signal menu_base_focus_entered(menu_button: MenuBaseButton, base: Base)
signal menu_base_focus_exited(menu_button: MenuBaseButton, base: Base)

func set_base(base_to_set: Base):
	base = base_to_set

func _on_pressed():
	menu_base_pressed.emit(self, base)

func _on_focus_entered():
	menu_base_focus_entered.emit(self, base)

func _on_focus_exited():
	menu_base_focus_exited.emit(self, base)
