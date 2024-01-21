class_name Continents extends Resource


enum Type {EUROPE, NORTH_AMERICA, SOUTH_AMERICA, AFRICA, ASIA, OCEANIA, ARCTIC, ANTARCTICA}

@export var europe = Continent.new(Type.EUROPE)
@export var north_america = Continent.new(Type.NORTH_AMERICA)
@export var south_america = Continent.new(Type.SOUTH_AMERICA)
@export var africa = Continent.new(Type.AFRICA)
@export var asia = Continent.new(Type.ASIA)
@export var oceania = Continent.new(Type.OCEANIA)
@export var arctic = Continent.new(Type.ARCTIC)
@export var antarctica = Continent.new(Type.ANTARCTICA)

var types = {
	Type.EUROPE: europe,
	Type.NORTH_AMERICA: north_america,
	Type.SOUTH_AMERICA: south_america,
	Type.AFRICA: africa,
	Type.ASIA: asia,
	Type.OCEANIA: oceania,
	Type.ARCTIC: arctic,
	Type.ANTARCTICA: antarctica,
}
