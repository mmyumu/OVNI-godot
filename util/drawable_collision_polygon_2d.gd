class_name DrawableCollisionPolygon2D extends CollisionPolygon2D

@export var color: Color = Color.CADET_BLUE:
	set(value):
		color = value
		queue_redraw()

@export var outline_color: Color = Color("db996a"):
	set(value):
		outline_color = value
		queue_redraw()

@export var outline_width: float = 2.0:
	set(value):
		outline_width = value
		queue_redraw()


func _draw():
	var poly = get_polygon()
	
	for i in range(1 , poly.size()):
		draw_line(poly[i-1] , poly[i], outline_color , outline_width)
	draw_line(poly[poly.size() - 1] , poly[0], outline_color , outline_width)
	draw_polygon(poly, PackedColorArray([color]))
