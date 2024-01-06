extends Node

func _ready():
	Datetimer.day_changed.connect(_on_day_changed)

func _on_global_menu_new_base_selected():
	Global.last_time_factor = Datetimer.time_factor
	Datetimer.time_factor = 1.
	$GlobalMenu.disable()
	$EarthLayout.set_creating_new_base()

func _on_earth_layout_base_creation_over():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	await get_tree().create_timer(0.1).timeout
	$GlobalMenu/BasesSubMenu.build()
	$GlobalMenu.enable()

func _on_day_changed(date: Datetime):
	Saver.save_data()

func _on_earth_layout_attack_spawned(attack: Attack):
	$GlobalMenu/AttacksSubMenu.build()

func _on_bases_sub_menu_menu_object_focus_entered(menu_button: MenuObjectButton, base: Base, parent_object: Object):
	$EarthLayout.highlight_base(base)

func _on_bases_sub_menu_menu_object_focus_exited(menu_button: MenuObjectButton, object: Base, parent_object: Object):
	$EarthLayout.unhighlight_base()

func _on_attacks_sub_menu_menu_object_focus_exited(menu_button: MenuObjectButton, attack: Attack, parent_object: Object):
	$EarthLayout.unhighlight_attack()

func _on_attacks_sub_menu_menu_object_focus_entered(menu_button: MenuObjectButton, attack: Attack, parent_object: Object):
	$EarthLayout.highlight_attack(attack)

func _on_event_ships_sub_menu_menu_object_focus_entered(menu_button: MenuObjectButton, ship: Ship, attack: Attack):
	$EarthLayout.show_event_info(ship, attack)

func _on_event_ships_sub_menu_menu_object_focus_exited(menu_button: MenuObjectButton, ship: Ship, attack: Attack):
	$EarthLayout.hide_event_info(ship, attack)

func _on_event_ships_sub_menu_menu_object_pressed(menu_button, ship: Ship, attack: Attack):
	if ship.at_destination(attack):
		Global.last_time_factor = Datetimer.time_factor
		Datetimer.time_factor = 1.
		Global.current_attack = attack
		Global.current_ship = ship
		get_tree().change_scene_to_file("res://shootemup/main.tscn")
	else:
		ship.set_attack(attack)
		ship.move()
