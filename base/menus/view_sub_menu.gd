extends ObjectSubMenu


func get_menu_data(parent_object: Object) -> Array[MenuDatum]:
	var menu_data: Array[MenuDatum] = []

	assert(parent_object is Base)
	
	for building in parent_object.base_layout.buildings:
		var menu_datum: MenuDatum = MenuDatum.new()
		menu_datum.object = building
		menu_datum.button_name = building.get_template().name
		menu_datum.button_text = building.get_template().name
		
		menu_data.append(menu_datum)

	return menu_data
