@tool
extends TextureRect

@export var color: Color = Color("bc7235"):
	set(value):
		color = value
		queue_redraw()

@export_range(0, 10, 0.01) var thickness: float = 1.0:
	set(value):
		thickness = value
		queue_redraw()

@export_range(0, 10, 1) var padding: int = 1:
	set(value):
		padding = value
		queue_redraw()

func _draw():
	var width = texture.get_width()
	var height = texture.get_height()
	
	var top_left = Vector2(position.x - padding, position.y - padding)
	var top_right = Vector2(position.x + width + padding, position.y - padding)
	var bottom_left = Vector2(position.x - padding, position.y + height + padding)
	var bottom_right = Vector2(position.x + width + padding, position.y + height + padding)

	draw_line(top_left, top_right, color, thickness)
	draw_line(top_right, bottom_right, color, thickness)
	draw_line(bottom_right, bottom_left, color, thickness)
	draw_line(bottom_left, top_left, color, thickness)
