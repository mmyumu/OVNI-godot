class_name ConstructionsTemplatesData extends Resource


enum Type {HANGAR, RESEARCH, ARMORY, HOSPITAL}

@export var hangar = ConstructionTemplateData.new(Type.HANGAR, "Hangar", 400000)
@export var research = ConstructionTemplateData.new(Type.RESEARCH, "Research", 100000)
@export var armory = ConstructionTemplateData.new(Type.ARMORY, "Armory",100000)
@export var hospital = ConstructionTemplateData.new(Type.HOSPITAL, "Hospital", 100000)

var templates = {
	Type.HANGAR: hangar,
	Type.RESEARCH: research,
	Type.ARMORY: armory,
	Type.HOSPITAL: hospital,
}

const SCENES = {
	Type.HANGAR: preload("res://base/constructions/hangar.tscn"),
	Type.RESEARCH: preload("res://base/constructions/research_facility.tscn"),
	Type.ARMORY: preload("res://base/constructions/armory.tscn"),
	Type.HOSPITAL: preload("res://base/constructions/hospital.tscn")
}
