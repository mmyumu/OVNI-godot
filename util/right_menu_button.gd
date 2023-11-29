class_name RightMenuButton extends Button

var base

signal base_pressed(base: BaseData)

func set_base(base_to_set: BaseData):
	base = base_to_set

func _on_pressed():
	base_pressed.emit(base)
