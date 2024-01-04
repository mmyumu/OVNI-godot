class_name ConstructionTemplateData extends Resource

@export var type: ConstructionsTemplatesData.Type
@export var name: String
@export var cost: int

func _init(_type: ConstructionsTemplatesData.Type, _name: String, _cost: int):
	type = _type
	name = _name
	cost = _cost
