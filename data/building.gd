class_name Building extends Resource


@export var template_type: BuildingTemplates.Type
@export var location: Vector2
@export var rotation: float
@export var construction_date: Datetime
@export var construction_status: Construction.Status


func start_construction():
	construction_date = Datetime.new(Saver.data.datetime.timestamp)
	construction_status = Construction.Status.IN_PROGRESS

func get_scene():
	return Saver.data.building_templates.scenes[template_type]

func get_template():
	return Saver.data.building_templates.templates[template_type]
