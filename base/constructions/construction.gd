@tool
class_name Construction extends Polygon2D

@export var outLine: Color = Color(0,0,0):
	set(value):
		outLine = value
		queue_redraw()
		
@export var width: float = 2.0:
	set(value):
		width = value
		queue_redraw()

func _draw():
	var poly = get_polygon()
	for i in range(1 , poly.size()):
		draw_line(poly[i-1] , poly[i], outLine , width)
	draw_line(poly[poly.size() - 1] , poly[0], outLine , width)

func set_placing_mode():
	# Blink/low opacity?
	print("placing mode enabled")

func placed():
	# Stop blinking/strong opacity?
	# Play construction sound
	print("placed")
