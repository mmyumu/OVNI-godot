extends SubMenu

#func _ready():
	#pass

func custom_connect():
	super.custom_connect()
	MastermindIntel.attack_spawned.connect(_on_attack_spawned)

func get_menu_data(parent_object: Object) -> Array[MenuDatum]:
	var menu_data: Array[MenuDatum] = []
	for base in Saver.data.get_bases():
		for ship in base.get_ships():
			var menu_datum = MenuDatum.new()
			menu_datum.object = ship
			menu_datum.button_name = "%s_%s" % [base.name, ship.name]
			menu_datum.button_text = "%s: %s" % [base.name, ship.name]
			menu_datum.font_color = Color.WHITE
			
			if ship.at_destination(parent_object):
				menu_datum.font_color = Color.DARK_RED

			menu_data.append(menu_datum)
	return menu_data

func _on_attack_spawned():
	build()
