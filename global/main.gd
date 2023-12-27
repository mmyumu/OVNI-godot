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
#	$GlobalMenu/EventShipsSubMenu.build()
	$GlobalMenu.enable()

func _on_day_changed(date: DatetimeData):
	Saver.save_data()

func _on_earth_layout_attack_spawned(attack: AttackData):
	$GlobalMenu/AttacksSubMenu.build()

func _on_bases_sub_menu_menu_object_focus_entered(menu_button: MenuObjectButton, base: BaseData, parent_object: Object):
	$EarthLayout.highlight_base(base)

func _on_bases_sub_menu_menu_object_focus_exited(menu_button: MenuObjectButton, object: BaseData, parent_object: Object):
	$EarthLayout.unhighlight_base()

func _on_attacks_sub_menu_menu_object_focus_exited(menu_button: MenuObjectButton, attack: AttackData, parent_object: Object):
	$EarthLayout.unhighlight_attack()

func _on_attacks_sub_menu_menu_object_focus_entered(menu_button: MenuObjectButton, attack: AttackData, parent_object: Object):
	$EarthLayout.highlight_attack(attack)

func _on_event_ships_sub_menu_menu_object_focus_entered(menu_button: MenuObjectButton, ship: ShipData, attack: AttackData):
	$EarthLayout.show_event_info(ship, attack)

func _on_event_ships_sub_menu_menu_object_focus_exited(menu_button: MenuObjectButton, ship: ShipData, attack: AttackData):
	$EarthLayout.hide_event_info(ship, attack)

func _on_event_ships_sub_menu_menu_object_pressed(menu_button, ship: ShipData, attack: AttackData):
	ship.set_attack(attack)
	ship.move()
