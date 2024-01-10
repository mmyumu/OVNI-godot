extends SubMenu

func custom_connect():
	super.custom_connect()
	Headquarters.ships_changed.connect(_on_ships_changed)

func get_menu_data(parent_object: Object) -> Array[MenuDatum]:
	var menu_data: Array[MenuDatum] = []
	
	for base in Saver.data.get_bases():
		for ship in base.get_ships():
			var menu_datum: MenuDatum = MenuDatum.new()
			menu_datum.object = base
			menu_datum.button_name = "%s_%s" % [base.name, ship.name]
			menu_datum.button_text = "%s: %s" % [base.name, ship.name]
			menu_data.append(menu_datum)

	return menu_data

func _on_ships_changed(changed_ships: Array[Ship]):
	build()
