extends ObjectSubMenu

func custom_connect():
	#MastermindIntel.attack_spawned.connect(_on_notification)
	pass

func get_menu_data(parent_object: Object) -> Array[MenuDatum]:
	var menu_data: Array[MenuDatum] = []
	
	for notification in Saver.data.get_unread_notifications():
		var menu_datum: MenuDatum = MenuDatum.new()
		menu_datum.object = notification
		menu_datum.button_name = notification.name
		menu_datum.button_text = notification.name
		
		menu_data.append(menu_datum)

	return menu_data

func _on_notification(notification: Notification):
	build()
