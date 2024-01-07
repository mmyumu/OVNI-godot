class_name Data extends Resource


@export var datetime: Datetime = Datetime.new()
@export var bases: Dictionary = {}
@export var mastermind: MasterMind = MasterMind.new()
@export var earth: Earth = Earth.new()
@export var ships: Dictionary = {}
@export var money: int = 500000
@export var building_templates: BuildingTemplates = BuildingTemplates.new()

@export var base_construction_duration: int = 12 * 60 * 60

func get_data_name():
	if len(bases) > 0:
		return bases[bases.keys()[0]].name
	else:
		return "New game"

func add_base(base: Base):
	bases[base.id] = base

func add_ship(ship: Ship):
	ships[ship.id] = ship

func get_bases():
	var bases_to_get: Array[Base] = []
	for base_id in bases:
		var base: Base = bases[base_id]
		bases_to_get.append(base)
	return bases_to_get

#func get_base_in_construction():
	#var bases_to_get: Array[Base] = []
	#for base_id in bases:
		#var base: Base = bases[base_id]
		#if base.construction_status == Construction.Status.IN_PROGRESS:
			#bases_to_get.append(base)
	#return bases_to_get	

func get_ships():
	var ships_to_get: Array[Ship] = []
	for ship_id in ships:
		var ship: Ship = ships[ship_id]
		ships_to_get.append(ship)
	return ships_to_get
