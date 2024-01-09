extends Node


signal bases_changed()
signal buildings_changed()

func _process(delta):
	check_constructions()

func check_constructions():
	var has_bases_changed: bool = false
	
	for base in Saver.data.get_bases():
		if base.construction_status == Construction.Status.IN_PROGRESS:
			if Saver.data.datetime.timestamp >= base.construction_date.timestamp + Saver.data.base_construction_duration:
				base.construction_status = Construction.Status.DONE
				has_bases_changed = true
				print("Construction of base %s is finished" % base.name)
		else:
			check_building_constructions(base)
	if has_bases_changed:
		bases_changed.emit()

func check_building_constructions(base: Base):
	var has_buildings_changed: bool = false
	
	for building in base.base_layout.buildings:
		if building.construction_status == Construction.Status.IN_PROGRESS:
			var building_template = Saver.data.building_templates.templates[building.template_type]
			if Saver.data.datetime.timestamp >= building.construction_date.timestamp + building_template.construction_duration:
				building.construction_status = Construction.Status.DONE
				has_buildings_changed = true
				print("Construction of building %s in base %s is finished" % [building.template_type, base.name])
	if has_buildings_changed:
		buildings_changed.emit()

func start_base_construction(base: Base):
	base.start_construction()
	Money.spend(base.cost)
	Saver.data.add_base(base)
	Saver.save_data()
	bases_changed.emit()

func start_building_construction(base: Base, building: Building):
	building.start_construction()
	base.base_layout.buildings.append(building)
	var building_template = Saver.data.building_templates.templates[building.template_type]
	Money.spend(building_template.cost)
	Saver.save_data()
	buildings_changed.emit()
