class_name Notification extends Resource

enum Status {UNREAD, READ, DELETED}

@export var name: String
@export var status: Status = Status.UNREAD
