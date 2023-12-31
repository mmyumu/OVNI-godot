class_name BuildingTemplates extends Resource


enum Type {HANGAR, RESEARCH, ARMORY, HOSPITAL}

@export var hangar = BuildingTemplate.new(Type.HANGAR, "Hangar", 400000, 8 * 60 * 60)
@export var research = BuildingTemplate.new(Type.RESEARCH, "Research", 100000, 8 * 60 * 60)
@export var armory = BuildingTemplate.new(Type.ARMORY, "Armory",100000, 8 * 60 * 60)
@export var hospital = BuildingTemplate.new(Type.HOSPITAL, "Hospital", 100000, 8 * 60 * 60)

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
