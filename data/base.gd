class_name BaseData extends Resource

const uuid_util = preload('res://addons/uuid/uuid.gd')

@export var id: String
@export var name: String
@export var location: Vector2
@export var base_layout: BaseLayoutData = BaseLayoutData.new()
@export var ships: Array[ShipData] = []

func _init():
	id = uuid_util.v4()
