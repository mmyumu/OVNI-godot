extends Node

var current_base: BaseData
var last_menu_button_path: NodePath
var last_time_factor: float

func get_current_base():
	if current_base:
		return current_base
	else:
		var b = BaseData.new()
		b.name = "dummy"
		b.location = Vector2.ZERO
		return b
