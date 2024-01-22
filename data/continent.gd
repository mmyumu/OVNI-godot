class_name Continent extends Resource

@export var type: Continents.Type
@export var confidence: float = 1.
@export var gdp: float

func _init(_type: Continents.Type, _gdp: float):
	type = _type
	gdp = _gdp
