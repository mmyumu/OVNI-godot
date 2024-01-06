class_name Data extends Resource


@export var datetime: DatetimeData = DatetimeData.new()
@export var bases: Dictionary = {}
@export var mastermind: MasterMindData = MasterMindData.new()
@export var earth: EarthData = EarthData.new()
@export var ships: Dictionary = {}
@export var money: int = 500000
@export var building_templates: BuildingTemplatesData = BuildingTemplatesData.new()

func get_data_name():
	if len(bases) > 0:
		return bases[bases.keys()[0]].name
	else:
		return "New game"

func add_base(base: BaseData):
	bases[base.id] = base

func add_ship(ship: ShipData):
	ships[ship.id] = ship

func get_bases():
	var bases_to_get: Array[BaseData] = []
	for base_id in bases:
		var base: BaseData = bases[base_id]
		bases_to_get.append(base)
	return bases_to_get

func get_ships():
	var ships_to_get: Array[ShipData] = []
	for ship_id in ships:
		var ship: ShipData = ships[ship_id]
		ships_to_get.append(ship)
	return ships_to_get
