class_name BuildingTemplateData extends Resource

@export var type: BuildingTemplatesData.Type
@export var name: String
@export var cost: int

func _init(_type: BuildingTemplatesData.Type, _name: String, _cost: int):
	type = _type
	name = _name
	cost = _cost
