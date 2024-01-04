class_name BuildSubMenu extends SubMenu

func get_menu_data(parent_object: Object) -> Array[MenuDatum]:
	var menu_data: Array[MenuDatum] = []
	
	for construction_template_id in Saver.data.construction_templates.templates:
		var construction_template = Saver.data.construction_templates.templates[construction_template_id]
		var menu_datum: MenuDatum = MenuDatum.new()
		menu_datum.object = construction_template
		menu_datum.button_name = construction_template.name
		menu_datum.button_text = construction_template.name
		
		menu_datum.disabled = construction_template.cost > Saver.data.money
		
		menu_data.append(menu_datum)

	return menu_data
