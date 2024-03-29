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
	for building in Global.get_current_base().base_layout.buildings:
		var building_to_place = building.get_scene().instantiate()
		building_to_place.position.x = building.location.x * grid_step
		building_to_place.position.y = building.location.y * grid_step
		building_to_place.rotation = building.rotation
		add_building(building, building_to_place)

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

func set_placing(building_to_place: BuildingToPlace):
	building_to_place.position.x = int(width / 2) * grid_step
	building_to_place.position.y = int(height / 2) * grid_step
	add_child(building_to_place)

func get_location(building_to_place: BuildingToPlace):
	return Vector2(building_to_place.position.x / grid_step, building_to_place.position.y / grid_step)

func add_building(building: Building, building_to_place: BuildingToPlace):
	var building_placed = building_placed_scene.instantiate()
	building_placed.building = building
	building_placed.building_to_place = building_to_place
	add_child(building_placed)
