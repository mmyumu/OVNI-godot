@tool
class_name Construction extends Polygon2D

@export var outline: Color = Color("a75236"):
	set(value):
		outline = value
		queue_redraw()

@export var width: float = 2.0:
	set(value):
		width = value
		queue_redraw()


var layout = [[0, 1, 0],
			  [1, 1, 1],
			  [0, 1, 0]]

var layout_polygon = Polygon2D.new()

#func _ready():
#	var cell_size = 10
##	var polygons = []
#
#	var packed_poly
#	for row in range(len(layout)):
#		for col in range(len(layout[row])):
#			if layout[row][col] == 1:
#				print("Add cell %s,%s" % [row, col])
##				var new_packed_poly = Polygon2D.new()
#				var new_packed_poly = PackedVector2Array([
#					Vector2(row * cell_size - cell_size / 2, col * cell_size - cell_size / 2),
#					Vector2(row * cell_size - cell_size / 2, col * cell_size + cell_size / 2),
#					Vector2(row * cell_size + cell_size / 2, col * cell_size + cell_size / 2),
#					Vector2(row * cell_size + cell_size / 2, col * cell_size - cell_size / 2),
#				])
#
#				if !packed_poly:
#					packed_poly = new_packed_poly
#				else:
#					packed_poly = Geometry2D.merge_polygons(packed_poly, new_packed_poly)
#
#				var zepoly = Polygon2D.new()
#				zepoly.set_polygon(packed_poly)
#				add_child(zepoly)
##				polygons.append(poly)
#	set_polygon(packed_poly)
#	print("ready set poly")
##	add_child(layout_polygon)
#
#
##				add_child(poly)
##	poly.set_polygon(PackedVector2Array([Vector2(40, 40),
##								  Vector2(40, 50),
##								  Vector2(50, 50),
##								  Vector2(50, 40)
##								]))

func _draw():
	var poly = get_polygon()
	for i in range(1 , poly.size()):
		print("draw line %s" % i)
		draw_line(poly[i-1] , poly[i], outline , width)
	draw_line(poly[poly.size() - 1] , poly[0], outline , width)

func set_placing_mode():
	# Blink/low opacity?
	print("placing mode enabled")

func move_right(width: int, height: int, grid_step: int):
	position.x += grid_step

func move_left(width: int, height: int, grid_step: int):
	position.x -= grid_step

func move_up(width: int, height: int, grid_step: int):
	position.y -= grid_step

func move_down(width: int, height: int, grid_step: int):
	position.y += grid_step

func validate_placing(grid_step: int):
	# Stop blinking/strong opacity?
	# Play construction sound
	print("validate placing")

func cancel_placing():
	queue_free()

