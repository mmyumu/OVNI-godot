@tool
extends Node2D

@export var width: int = 20:
	set(value):
		width = value
		queue_redraw()

@export var height: int = 15:
	set(value):
		height = value
		queue_redraw()

@export var grid_step: int = 32:
	set(value):
		grid_step = value
		queue_redraw()
		
@export var color: Color = Color.WEB_GRAY:
	set(value):
		color = value
		queue_redraw()
		
@export var thickness: float = 1.0:
	set(value):
		thickness = value
		queue_redraw()

var building_placed_scene: PackedScene = preload("res://base/buildings/building_placed.tscn")

func _ready():
	for building_data in Global.get_current_base().base_layout.buildings:
		var building = Saver.data.building_templates.scenes[building_data.template_type].instantiate()
		building.position.x = building_data.location.x * grid_step
		building.position.y = building_data.location.y * grid_step
		building.rotation = building_data.rotation
		add_building(building)

func _draw():
	draw_grid()

func draw_grid():
	draw_horizontal_lines()
	draw_vertical_lines()

func draw_horizontal_lines():
	for y in range(height + 1):
		draw_line(Vector2(0, y * grid_step), Vector2(get_width(), y * grid_step), color, thickness)
		
func draw_vertical_lines():
	for x in range(width + 1):
		draw_line(Vector2(x * grid_step, 0), Vector2(x * grid_step, get_height()), color, thickness)

func get_width():
	return width * grid_step

func get_height():
	return height * grid_step

func set_placing(building_to_place: Building):
	building_to_place.position.x = int(width / 2) * grid_step
	building_to_place.position.y = int(height / 2) * grid_step
	add_child(building_to_place)

func validate_placing(building: Building):
	add_building(building)
	
	var building_data = BuildingData.new()
	building_data.location = Vector2(building.position.x / grid_step, building.position.y / grid_step)
	building_data.rotation = building.rotation
	building_data.template_type = building.template_type
	Global.get_current_base().base_layout.buildings.append(building_data)
	Saver.save_data()


func add_building(building: Building):
	var building_placed = building_placed_scene.instantiate()
	building_placed.building = building
	add_child(building_placed)
