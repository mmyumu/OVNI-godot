class_name GlobalMenu extends Menu

signal new_base_selected()

func _ready():
	display_root_menu()
	
	if not Global.last_menu_button_path.is_empty():
		display_bases_menu()
		get_node(Global.last_menu_button_path).grab_focus()
		Global.last_menu_button_path = ""

func _input(event):
	if event.is_action_pressed("cancel"):
		if $BasesSubMenu.visible == true:
			display_root_menu()
		elif $AttacksSubMenu.visible == true:
			display_root_menu()
		elif $AttackShipsSubMenu.visible == true:
			display_attacks_menu()

func grab_default_focus():
	$RootMenu/Bases.grab_focus()

func _on_bases_pressed():
	display_bases_menu()

func _on_events_pressed():
	display_attacks_menu()

func display_bases_menu():
	hide_all_menus()
	$BasesSubMenu.build()
	$BasesSubMenu.display()

func display_attacks_menu():
	hide_all_menus()
	$AttacksSubMenu.build()
	$AttacksSubMenu.display()

func _on_quit_pressed():
	Datetimer.time_factor = 0.
	Saver.save_data()
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_bases_sub_menu_menu_object_pressed(menu_button: MenuObjectButton, base: Base, _parent_object: Object):
	Global.current_base = base
	Global.last_menu_button_path = menu_button.get_path()
	Global.last_time_factor = Datetimer.time_factor
	Datetimer.time_factor = 1.
	get_tree().change_scene_to_file("res://base/main.tscn")

func _on_bases_sub_menu_new_base_pressed():
	last_focus_control = $BasesSubMenu/NewBase
	new_base_selected.emit()

func _on_attacks_sub_menu_menu_object_pressed(menu_button, object, parent_object):
	hide_all_menus()
	$AttackShipsSubMenu.build(object)
	$AttackShipsSubMenu.display()

func _on_bases_sub_menu_back_pressed():
	display_root_menu()

func _on_attacks_sub_menu_back_pressed():
	display_root_menu()

func _on_event_ships_sub_menu_back_pressed():
	display_attacks_menu()
