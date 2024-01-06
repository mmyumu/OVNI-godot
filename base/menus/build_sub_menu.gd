class_name BuildSubMenu extends SubMenu

func get_menu_data(parent_object: Object) -> Array[MenuDatum]:
	var menu_data: Array[MenuDatum] = []
	
	for building_template_id in Saver.data.building_templates.templates:
		var building_template = Saver.data.building_templates.templates[building_template_id]
		var menu_datum: MenuDatum = MenuDatum.new()
		menu_datum.object = building_template
		menu_datum.button_name = building_template.name
		menu_datum.button_text = building_template.name
		
		menu_datum.disabled = building_template.cost > Saver.data.money
		
		menu_data.append(menu_datum)

	return menu_data
