extends Node


func _ready():
	pass # Replace with function body.

func _process(delta):
	check_constructions()

func check_constructions():
	for base in Saver.data.get_bases():
		if base.construction_status == Construction.Status.IN_PROGRESS:
			if Saver.data.datetime.timestamp >= base.construction_date.timestamp + Saver.data.base_construction_duration:
				base.construction_status = Construction.Status.DONE
				print("Construction of base %s is finished" % base.name)
		else:
			check_building_constructions(base)

func check_building_constructions(base: Base):
	for building in base.base_layout.buildings:
		if building.construction_status == Construction.Status.IN_PROGRESS:
			var building_template = Saver.data.building_templates.templates[building.template_type]
			if Saver.data.datetime.timestamp >= building.construction_date.timestamp + building_template.construction_duration:
				base.construction_status = Construction.Status.DONE
				print("Construction of building %s in base %s is finished" % [building.template_type, base.name])

func start_building_construction(base: Base, building: Building):
	building.start_construction()
	base.base_layout.buildings.append(building)
	var building_template = Saver.data.building_templates.templates[building.template_type]
	Money.spend(building_template.cost)
	Saver.save_data()
