extends SubMenu

func get_menu_data() -> Array[MenuDatum]:
	var menu_data: Array[MenuDatum] = []
	
	for attack in Saver.data.mastermind.attacks_ongoing:
		var menu_datum: MenuDatum = MenuDatum.new()
		menu_datum.object = attack
		menu_datum.button_name = attack.name
		menu_datum.button_text = attack.name
		
		menu_data.append(menu_datum)

	return menu_data
