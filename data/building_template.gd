class_name BuildingTemplate extends Resource

@export var type: BuildingTemplates.Type
@export var name: String
@export var cost: int
@export var construction_duration: int

func _init(_type: BuildingTemplates.Type, _name: String, _cost: int, _construction_duration: int):
	type = _type
	name = _name
	cost = _cost
	construction_duration = _construction_duration
