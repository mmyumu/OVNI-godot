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
		elif $ShipsSubMenu.visible == true:
			display_root_menu()
		elif $ShipSubMenu.visible == true:
			display_ships_menu()

func grab_default_focus():
	$RootMenu/Bases.grab_focus()

func _on_bases_pressed():
	display_bases_menu()

func _on_events_pressed():
	display_attacks_menu()

func _on_ships_pressed():
	display_ships_menu()

func display_bases_menu():
	hide_all_menus()
	$BasesSubMenu.build()
	$BasesSubMenu.display()

func display_attacks_menu():
	hide_all_menus()
	$AttacksSubMenu.build()
	$AttacksSubMenu.display()

func display_attack_menu(attack: Attack):
	hide_all_menus()
	$AttackShipsSubMenu.build(attack)
	$AttackShipsSubMenu.display()

func display_ships_menu():
	hide_all_menus()
	$ShipsSubMenu.build()
	$ShipsSubMenu.display()

func display_ship_menu(ship: Ship):
	hide_all_menus()
	$ShipSubMenu.ship = ship
	$ShipSubMenu.display()

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

func _on_attacks_sub_menu_menu_object_pressed(menu_button, attack: Attack, parent_object):
	display_attack_menu(attack)

func _on_bases_sub_menu_back_pressed():
	display_root_menu()

func _on_attacks_sub_menu_back_pressed():
	display_root_menu()

func _on_ships_sub_menu_back_pressed():
	display_root_menu()

func _on_ships_sub_menu_menu_object_pressed(menu_button, ship: Ship, parent_object):
	display_ship_menu(ship)

func _on_ship_sub_menu_back_pressed():
	display_ships_menu()

func _on_attack_ships_sub_menu_back_pressed():
	display_attacks_menu()

func _on_ship_sub_menu_deploy_pressed(ship):
	pass # Replace with function body.

func _on_ship_sub_menu_goto_pressed(ship):
	pass # Replace with function body.

func _on_ship_sub_menu_return_pressed(ship):
	if not ship.hangared:
		ship.set_destination(ship.base)
