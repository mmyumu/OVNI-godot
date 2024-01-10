extends Node


signal bases_changed(bases: Array[Base])
signal buildings_changed(buildings: Array[Building])
signal ships_changed(ships: Array[Ship])

func _process(delta):
	check_constructions()

func check_constructions():
	var changed_bases: Array[Base] = []
	
	for base in Saver.data.get_bases():
		if base.construction_status == Construction.Status.IN_PROGRESS:
			if Saver.data.datetime.timestamp >= base.construction_date.timestamp + Saver.data.base_construction_duration:
				base.construction_status = Construction.Status.DONE
				base.construction_end = Datetime.new(Saver.data.datetime.timestamp)
				changed_bases.append(base)
				print("Construction of base %s is finished" % base.name)
		else:
			check_building_constructions(base)

	if len(changed_bases):
		bases_changed.emit(changed_bases)

func check_building_constructions(base: Base):
	var changed_buildings: Array[Building] = []
	
	for building in base.base_layout.buildings:
		if building.construction_status == Construction.Status.IN_PROGRESS:
			var building_template = Saver.data.building_templates.templates[building.template_type]
			if Saver.data.datetime.timestamp >= building.construction_date.timestamp + building_template.construction_duration:
				building.construction_status = Construction.Status.DONE
				finish_building_construction(base, building)
				changed_buildings.append(building)
				print("Construction of building %s in base %s is finished" % [building.template_type, base.name])

	if len(changed_buildings):
		buildings_changed.emit(changed_buildings)

func start_base_construction(base: Base):
	base.start_construction()
	Money.spend(base.cost)
	Saver.data.add_base(base)
	Saver.save_data()
	
	var changed_bases: Array[Base] = [base]
	bases_changed.emit(changed_bases)

func start_building_construction(base: Base, building: Building):
	building.start_construction()
	base.base_layout.buildings.append(building)
	var building_template = Saver.data.building_templates.templates[building.template_type]
	Money.spend(building_template.cost)
	Saver.save_data()
	
	var changed_buildings: Array[Building] = [building]
	buildings_changed.emit(changed_buildings)

func finish_building_construction(base: Base, building: Building):
	if building.template_type == BuildingTemplates.Type.HANGAR:
		var ship = Ship.new()
		ship.name = "Raptor v2"
		ship.base = base
		ship.location = base.location
		base.add_ship(ship)
		Saver.data.add_ship(ship)
		Saver.save_data()
		
		var changed_ships: Array[Ship] = [ship]
		ships_changed.emit(changed_ships)
