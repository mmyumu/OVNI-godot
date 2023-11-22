extends Node


func _on_global_menu_new_base_selected():
	$GlobalMenu.disable()
	$EarthLayout.set_creating_new_base()

func _on_earth_layout_base_creation_over():
	await get_tree().create_timer(0.1).timeout
	$GlobalMenu.enable()
