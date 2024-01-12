class_name BaseMenu extends Menu

func _ready():
	display_root_menu()

func _input(event):
	if event.is_action_pressed("cancel"):
		if $BuildSubMenu.visible == true:
			display_root_menu()
		#elif $ViewSubMenu.visible == true:
			#display_root_menu()
		elif $RootMenu.visible == true:
			_on_back_pressed()

func grab_default_focus():
	$RootMenu/Build.grab_focus()

func _on_build_pressed():
	display_build_menu()

func _on_view_pressed():
	display_view_menu()

func display_build_menu():
	hide_all_menus()
	$BuildSubMenu.build()
	$BuildSubMenu.display()

func display_view_menu():
	#hide_all_menus()
	#$ViewSubMenu.display()
	pass

func _on_back_pressed():
	get_tree().change_scene_to_file("res://global/main.tscn")

func _on_build_sub_menu_back_pressed(parent_object: Object):
	display_root_menu()


func _on_build_sub_menu_menu_object_pressed(menu_button, object, parent_object):
	last_focus_control = menu_button
