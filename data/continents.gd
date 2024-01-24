class_name Continents extends Resource


enum Type {EUROPE, NORTH_AMERICA, SOUTH_AMERICA, AFRICA, ASIA, OCEANIA, ARCTIC, ANTARCTICA}

@export var europe = Continent.new(Type.EUROPE, "Europe", 35000.)
@export var north_america = Continent.new(Type.NORTH_AMERICA, "North America", 40000.)
@export var south_america = Continent.new(Type.SOUTH_AMERICA, "South America", 10000.)
@export var africa = Continent.new(Type.AFRICA, "Africa", 5000.)
@export var asia = Continent.new(Type.ASIA, "Asia", 45000.)
@export var oceania = Continent.new(Type.OCEANIA, "Oceania", 3000.)
@export var arctic = Continent.new(Type.ARCTIC, "Arctic", 0.)
@export var antarctica = Continent.new(Type.ANTARCTICA, "Antarctica", 0.)

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
