extends Node

func _ready():
	Datetimer.day_changed.connect(_on_day_changed)

func _on_global_menu_new_base_selected():
	Global.last_time_factor = Datetimer.time_factor
	Datetimer.time_factor = 1.
	$GlobalMenu.disable()
	$EarthLayout.set_creating_new_base()

func _on_earth_layout_base_creation_over():
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	await get_tree().create_timer(0.1).timeout
	$GlobalMenu.reenable()

func _on_earth_layout_goto_selection_over():
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	await get_tree().create_timer(0.1).timeout
	$GlobalMenu.reenable()

func _on_day_changed(date: Datetime):
	Saver.save_data()

func _on_bases_sub_menu_menu_object_focus_entered(menu_button: MenuObjectButton, base: Base, parent_object: Object):
	$EarthLayout.highlight_base(base)
	$EarthLayout.show_base_info(base)

func _on_bases_sub_menu_menu_object_focus_exited(menu_button: MenuObjectButton, base: Base, parent_object: Object):
	$EarthLayout.unhighlight_base()
	$EarthLayout.hide_base_info(base)

func _on_attacks_sub_menu_menu_object_focus_exited(menu_button: MenuObjectButton, attack: Attack, parent_object: Object):
	$EarthLayout.unhighlight_attack()
	$EarthLayout.hide_attack_info(null, attack)

func _on_attacks_sub_menu_menu_object_focus_entered(menu_button: MenuObjectButton, attack: Attack, parent_object: Object):
	$EarthLayout.highlight_attack(attack)
	$EarthLayout.show_attack_info(null, attack)

func _on_attack_ships_sub_menu_menu_object_focus_entered(menu_button: MenuObjectButton, ship: Ship, attack: Attack):
	$EarthLayout.show_attack_info(ship, attack)

func _on_attack_ships_sub_menu_menu_object_focus_exited(menu_button: MenuObjectButton, ship: Ship, attack: Attack):
	$EarthLayout.hide_attack_info(ship, attack)

func _on_attack_ships_sub_menu_menu_object_pressed(menu_button, ship: Ship, attack: Attack):
	ship_attack(ship, attack)

func _on_ship_deploy_attacks_sub_menu_menu_object_focus_entered(menu_button, attack: Attack, ship: Ship):
	$EarthLayout.highlight_attack(attack)
	$EarthLayout.show_attack_info(ship, attack)

func _on_ship_deploy_attacks_sub_menu_menu_object_focus_exited(menu_button, attack: Attack, ship: Ship):
	$EarthLayout.unhighlight_attack()
	$EarthLayout.hide_attack_info(ship, attack)

func _on_ship_deploy_attacks_sub_menu_menu_object_pressed(menu_button, attack: Attack, ship: Ship):
	ship_attack(ship, attack)

func ship_attack(ship: Ship, attack: Attack):
	if ship.attack == attack and ship.at_destination(attack):
		Global.last_time_factor = Datetimer.time_factor
		Datetimer.time_factor = 1.
		Global.current_attack = attack
		Global.current_ship = ship
		get_tree().change_scene_to_file("res://shootemup/main.tscn")
	else:
		Ships.move_and_attack(ship, attack)


func _on_global_menu_goto_pressed(ship: Ship):
	Global.last_time_factor = Datetimer.time_factor
	Datetimer.time_factor = 1.
	$GlobalMenu.disable()
	$EarthLayout.set_selecting_goto(ship)


func _on_notifications_sub_menu_menu_object_pressed(menu_button, notification: Notification, parent_object):
	$EarthLayout.display_notification(notification)
