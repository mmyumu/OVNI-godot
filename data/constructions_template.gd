class_name BuildingTemplatesData extends Resource


enum Type {HANGAR, RESEARCH, ARMORY, HOSPITAL}

@export var hangar = BuildingTemplateData.new(Type.HANGAR, "Hangar", 400000)
@export var research = BuildingTemplateData.new(Type.RESEARCH, "Research", 100000)
@export var armory = BuildingTemplateData.new(Type.ARMORY, "Armory",100000)
@export var hospital = BuildingTemplateData.new(Type.HOSPITAL, "Hospital", 100000)

var templates = {
	Type.HANGAR: hangar,
	Type.RESEARCH: research,
	Type.ARMORY: armory,
	Type.HOSPITAL: hospital,
}

var scenes = {
	Type.HANGAR: load("res://base/buildings/hangar.tscn"),
	Type.RESEARCH: load("res://base/buildings/research_facility.tscn"),
	Type.ARMORY: load("res://base/buildings/armory.tscn"),
	Type.HOSPITAL: load("res://base/buildings/hospital.tscn")
}
