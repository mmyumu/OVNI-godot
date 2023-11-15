@tool
extends Node

func _on_base_menu_construction_selected(construction_scene):
	var construction = construction_scene.instantiate()
	construction.set_placing_mode()
	$BaseLayout.set_placing(construction)


func _on_base_layout_placing_over():
	$BaseMenu.set_last_focus()
