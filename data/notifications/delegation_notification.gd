class_name DelegationNotification extends Notification

const scene = preload('res://global/notifications/delegation_notification_panel.tscn')

@export var report: MoneyReport

func get_id_name():
	return "delegation"

func get_display_name():
	return "Delegation"

func get_scene():
	return scene
