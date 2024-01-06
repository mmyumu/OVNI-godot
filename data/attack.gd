class_name Attack extends Resource

const uuid_util = preload('res://addons/uuid/uuid.gd')

enum Status {PLANNED, ON_GOING, OVER}

@export var id: String
@export var name: String
@export var status: Status
@export var datetime: Datetime = Datetime.new()
@export var location: Vector2

func _init():
	id = uuid_util.v4()
