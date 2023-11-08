extends Node


func _on_base_menu_construction_selected(construction_scene):
	var construction = construction_scene.instantiate()
	construction.set_placing_mode()
	$Base.set_placing(construction)
