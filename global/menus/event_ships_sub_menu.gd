extends SubMenu

func get_menu_data() -> Array[MenuDatum]:
	var menu_data: Array[MenuDatum] = []
	for base_id in Saver.data.bases:
		var base = Saver.data.bases[base_id]
		for ship in base.ships:
			var menu_datum = MenuDatum.new()
			menu_datum.object = ship
			menu_datum.button_name = "%s_%s" % [base.name, ship.name]
			menu_datum.button_text = "%s: %s" % [base.name, ship.name]
			menu_data.append(menu_datum)
	return menu_data
