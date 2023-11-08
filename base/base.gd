@tool
extends Node2D

@export var width: int = 1088:
	set(value):
		width = value
		queue_redraw()
		
@export var height: int = 704:
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
	for y in range(0, height + 1, grid_step):
		draw_line(Vector2(0, y), Vector2(width, y), color, thickness)
		
func draw_vertical_lines():
	for x in range(0, width + 1, grid_step):
		draw_line(Vector2(x, 0), Vector2(x, height), color, thickness)

func set_placing(construction: Construction):
	add_child(construction)
