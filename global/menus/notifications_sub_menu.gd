extends ObjectSubMenu

func custom_connect():
	NotificationsBox.notification_created.connect(_on_notification_changed)
	NotificationsBox.notification_updated.connect(_on_notification_changed)
	#MastermindIntel.attack_spawned.connect(_on_notification)
	pass

func get_menu_data(parent_object: Object) -> Array[MenuDatum]:
	var menu_data: Array[MenuDatum] = []
	
	for notification in Saver.data.get_notifications([Notification.Status.READ, Notification.Status.UNREAD]):
		var menu_datum: MenuDatum = MenuDatum.new()
		menu_datum.object = notification
		menu_datum.button_name = notification.name
		menu_datum.button_text = notification.name
		menu_datum.font_color = Color.WHITE
		
		if notification.status == Notification.Status.UNREAD:
			menu_datum.font_color = Color.DARK_RED
		
		menu_data.append(menu_datum)

	return menu_data

func _on_notification_changed(notification: Notification):
	build()
