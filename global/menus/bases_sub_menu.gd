extends SubMenu

func custom_connect():
	super.custom_connect()
	
	Headquarters.bases_changed.connect(_on_bases_changed)

func grab_default_focus():
	$NewBase.grab_focus()

func get_menu_data(parent_object: Object) -> Array[MenuDatum]:
	var menu_data: Array[MenuDatum] = []
	
	for base in Saver.data.get_bases():
		var menu_datum: MenuDatum = MenuDatum.new()
		menu_datum.object = base
		menu_datum.button_name = base.name
		menu_datum.button_text = base.name
		menu_datum.disabled = base.construction_status == Construction.Status.IN_PROGRESS
		menu_data.append(menu_datum)

	return menu_data

func _on_bases_changed():
	build()
