extends SubMenu

func grab_default_focus():
	$NewBase.grab_focus()

func get_menu_data() -> Array[MenuDatum]:
	var menu_data: Array[MenuDatum] = []
	
	for base_id in Saver.data.bases:
		var base = Saver.data.bases[base_id]
		var menu_datum: MenuDatum = MenuDatum.new()
		menu_datum.object = base
		menu_datum.button_name = base.name
		menu_datum.button_text = base.name
		
		menu_data.append(menu_datum)

	return menu_data
