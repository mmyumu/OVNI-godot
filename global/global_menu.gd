extends Node2D

var last_focus_control

signal new_base_selected()

func _ready():
	display_root_menu()

func _input(event):
	if event.is_action_pressed("cancel"):
		display_root_menu()

func disable():
	for node in find_children("*", "Button", true):
		node.disabled = true
		node.set_focus_mode(0)
#		node.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	set_process_input(false)

func enable():
	for node in find_children("*", "Button", true):
		node.disabled = false
		node.set_focus_mode(2)
#		node.set_mouse_filter(Control.MOUSE_FILTER_STOP)
	last_focus_control.grab_focus()
	set_process_input(true)

func display_root_menu():
	$RootMenu.show()
	$BasesMenu.hide()
	
	$RootMenu/Bases.grab_focus()

func _on_save_pressed():
	print("should save")

func _on_bases_pressed():
	$RootMenu.hide()
	$BasesMenu.show()
	
	$BasesMenu/NewBase.grab_focus()

func _on_bases_back_pressed():
	display_root_menu()

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_new_base_pressed():
	last_focus_control = $BasesMenu/NewBase
	new_base_selected.emit()
