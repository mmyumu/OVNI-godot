class_name Menu extends Node2D

var last_focus_control
var nodes_disabled: Dictionary = {}

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
	var new_nodes_disabled = {}
	for node in find_children("*", "Button", true, false):
		new_nodes_disabled[node.get_instance_id()] = node.disabled
		node.disabled = true
		node.set_focus_mode(0)
	nodes_disabled = new_nodes_disabled
	set_process_input(false)

func reenable():
	for node in find_children("*", "Button", true, false):
		if node.get_instance_id() in nodes_disabled:
			node.disabled = nodes_disabled[node.get_instance_id()]
		#else:
			#node.disabled = false
		node.set_focus_mode(2)
	if last_focus_control:
		last_focus_control.grab_focus()
	set_process_input(true)
