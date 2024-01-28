class_name Notification extends Resource

enum Status {UNREAD, READ, DELETED}

#@export var name: String
@export var status: Status = Status.UNREAD

func get_id_name():
	pass

func get_display_name():
	pass

func get_scene():
	return null
