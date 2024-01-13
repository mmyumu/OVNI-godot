extends ObjectSubMenu

func custom_connect():
	super.custom_connect()
	MastermindIntel.attack_spawned.connect(_on_attack_spawned)
	Ships.ship_reached_attack.connect(_on_ship_reached_attack)
	Ships.ship_new_destination.connect(_on_ship_new_destination)

func get_menu_data(parent_object: Object) -> Array[MenuDatum]:
	var menu_data: Array[MenuDatum] = []
	for attack in Saver.data.mastermind.get_attacks_ongoing():
		var menu_datum: MenuDatum = MenuDatum.new()
		menu_datum.object = attack
		menu_datum.button_name = attack.name
		menu_datum.button_text = attack.name
		menu_datum.font_color = Color.WHITE
		
		if parent_object and parent_object.at_destination(attack) and parent_object.attack == attack:
			menu_datum.font_color = Color.DARK_RED
		
		menu_data.append(menu_datum)
	return menu_data

func _on_attack_spawned(attack: Attack):
	build()

func _on_ship_reached_attack(ship: Ship, attack: Attack):
	build()

func _on_ship_new_destination(ship: Ship):
	build()
