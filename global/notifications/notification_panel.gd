class_name NotificationPanel extends Node2D

var notification: Notification:
	set(value):
		notification = value
		notification_updated()

func _ready():
	$Window/VBoxContainer/MarginContainerButtons/HBoxContainer/OkButton.grab_focus()
	NotificationsBox.read(notification)

func notification_updated():
	pass

func _on_window_close_requested():
	queue_free()

func _on_delete_button_pressed():
	NotificationsBox.delete(notification)
	queue_free()


func _on_ok_button_pressed():
	queue_free()
