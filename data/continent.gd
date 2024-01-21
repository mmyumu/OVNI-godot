class_name Continent extends Resource

@export var type: Continents.Type
@export var confidence: float = 1.

func _init(_type: Continents.Type):
	type = _type
