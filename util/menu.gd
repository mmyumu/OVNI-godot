class_name Menu extends Node2D

var last_focus_control

func hide_all_menus():
	$RootMenu.hide()
	
	var sub_menus = find_children("*", "SubMenu", false, false)
	for sub_menu in sub_menus:
		sub_menu.hide()

func display_root_menu():
	hide_all_menus()
	$RootMenu.show()
	grab_default_focus()

func grab_default_focus():
	pass

func disable():
	for node in find_children("*", "Button", true, false):
		node.disabled = true
		node.set_focus_mode(0)
	set_process_input(false)

func enable():
	for node in find_children("*", "Button", true, false):
		node.disabled = false
		node.set_focus_mode(2)
	if last_focus_control:
		last_focus_control.grab_focus()
	set_process_input(true)
