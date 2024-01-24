class_name NotificationPanel extends Node2D

var notification: Notification

func _ready():
	NotificationsBox.read(notification)

func _on_window_close_requested():
	queue_free()

func _on_delete_button_pressed():
	NotificationsBox.delete(notification)
	queue_free()
