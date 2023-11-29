class_name MenuBaseButton extends Button

var base

signal menu_base_pressed(base: BaseData)

func set_base(base_to_set: BaseData):
	base = base_to_set

func _on_pressed():
	menu_base_pressed.emit(self, base)
