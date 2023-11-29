class_name ConstructionsData extends Resource


enum Type {RESEARCH, HOSPITAL}

const SCENES = {
	Type.RESEARCH: preload("res://base/constructions/research_facility.tscn"),
	Type.HOSPITAL: preload("res://base/constructions/hospital.tscn")
}
