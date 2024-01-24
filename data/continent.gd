class_name Continent extends Resource

@export var type: Continents.Type
@export var name: String
@export var confidence: float = 1.
@export var gdp: float

func _init(_type: Continents.Type, _name: String, _gdp: float):
	type = _type
	name = _name
	gdp = _gdp
