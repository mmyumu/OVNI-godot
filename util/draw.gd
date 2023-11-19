class_name Drawer extends Node2D

func draw_polygon2D(polygon, color: Color, outline_color: Color, outline_width: int):
	var poly = polygon.get_polygon()
	
	var idx = 0
	for p in poly:
		p.x += polygon.position.x
		p.y += polygon.position.y
		poly[idx] = p
		idx += 1
	
	for i in range(1 , poly.size()):
		draw_line(poly[i-1] , poly[i], outline_color , outline_width)
	draw_line(poly[poly.size() - 1] , poly[0], outline_color , outline_width)
	draw_polygon(poly, PackedColorArray([color]))
	print("new draw poly %s" % poly)
