extends ObjectSubMenu

func custom_connect():
	MastermindIntel.attack_spawned.connect(_on_attack_spawned)

func get_menu_data(parent_object: Object) -> Array[MenuDatum]:
	var menu_data: Array[MenuDatum] = []
	
	for attack in Saver.data.mastermind.get_attacks_ongoing():
		var menu_datum: MenuDatum = MenuDatum.new()
		menu_datum.object = attack
		menu_datum.button_name = attack.name
		menu_datum.button_text = attack.name
		
		menu_data.append(menu_datum)

	return menu_data

func _on_attack_spawned(attack: Attack):
	build()
