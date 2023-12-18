extends Node2D

var last_focus_control

signal new_base_selected()

func _ready():
	display_root_menu()
	
	if not Global.last_menu_button_path.is_empty():
		display_bases_menu()
		get_node(Global.last_menu_button_path).grab_focus()
		Global.last_menu_button_path = ""

func _input(event):
	if event.is_action_pressed("cancel") and not $RootMenu.visible:
		display_root_menu()

func disable():
	for node in find_children("*", "Button", true, false):
		node.disabled = true
		node.set_focus_mode(0)
	set_process_input(false)

func enable():
	for node in find_children("*", "Button", true, false):
		node.disabled = false
		node.set_focus_mode(2)
	last_focus_control.grab_focus()
	set_process_input(true)

func display_root_menu():
	$RootMenu.show()
	$BasesMenu.hide()
	$EventsMenu.hide()
	
	$RootMenu/Bases.grab_focus()

func _on_bases_pressed():
	display_bases_menu()

func _on_events_pressed():
	display_events_menu()

func display_bases_menu():
	$RootMenu.hide()
	$BasesMenu.display()

func display_events_menu():
	$RootMenu.hide()
	$EventsMenu.display()

func _on_quit_pressed():
	Datetimer.time_factor = 0.
	Saver.save_data()
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_bases_menu_new_base_pressed(new_base_button):
	last_focus_control = new_base_button
	new_base_selected.emit()

func _on_bases_menu_back_pressed():
	display_root_menu()

func _on_events_menu_back_pressed():
	display_root_menu()
