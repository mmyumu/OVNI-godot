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

func set_placing(construction_to_place: Construction):
	construction_to_place.position.x = int(width / 2) * grid_step
	construction_to_place.position.y = int(height / 2) * grid_step
	add_child(construction_to_place)

func validate_placing(construction: Construction):
	if construction.check_can_place():
		var collisionPolygon = CollisionPolygon2D.new()
		collisionPolygon.set_polygon(construction.get_collision_polygon().get_polygon())
		collisionPolygon.position = construction.get_collision_polygon().position
			
		var polygon = Polygon2D.new()
		polygon.set_polygon(construction.get_collision_polygon().get_polygon())
		polygon.position = construction.get_collision_polygon().position
		polygon.color = construction.color
		
		var area2D = Area2D.new()
		area2D.scale.x = 0.9
		area2D.scale.y = 0.9
		area2D.add_child(collisionPolygon)
		
		var node2D = Node2D.new()	
		node2D.position = construction.position
		node2D.add_child(area2D)
		node2D.add_child(polygon)
		
		add_child(node2D)
	else:
		construction.collision_highlight()
