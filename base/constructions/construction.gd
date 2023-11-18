@tool
class_name Construction extends CharacterBody2D

@export var outline: Color = Color("db996a"):
	set(value):
		outline = value
		queue_redraw()

@export var width: float = 2.0:
	set(value):
		width = value
		queue_redraw()

@export var color: Color = Color.CADET_BLUE:
	set(value):
		color = value
		queue_redraw()

var original_outline: Color
var can_place: bool
var first

func _ready():
	first = true
	original_outline = outline
	$Area2D/CollisionPolygon2D.set_polygon($CollisionPolygon2D.get_polygon())

func check_can_place():
	if len($Area2D.get_overlapping_areas()) > 0:
		outline = Color.DARK_RED
		can_place = false
		print("cannot place")
	else:
		outline = original_outline
		can_place = true
		print("can place")
	return can_place

func _draw():
	var poly = $CollisionPolygon2D.get_polygon()
	
	var idx = 0
	for p in poly:
		p.x += $CollisionPolygon2D.position.x
		p.y += $CollisionPolygon2D.position.y
		poly[idx] = p
		idx += 1
		
	
	for i in range(1 , poly.size()):
		draw_line(poly[i-1] , poly[i], outline , width)
	draw_line(poly[poly.size() - 1] , poly[0], outline , width)
	
#	poly = $Area2D/CollisionPolygon2D.get_polygon()
#	for i in range(1 , poly.size()):
#		draw_line(poly[i-1] , poly[i], Color.GREEN_YELLOW , width)
#	draw_line(poly[poly.size() - 1] , poly[0], Color.GREEN_YELLOW , width)
	
	draw_polygon(poly, PackedColorArray([color]))

func get_collision_polygon():
	return $CollisionPolygon2D

func set_placing_mode():
	color.a = 0.5
	# Blink/low opacity?

func move_right(grid_step: int):
	var collision = move_and_collide(Vector2.RIGHT * grid_step, true)
	if collision:
		collision_highlight()
	else:
		position.x += grid_step

func move_left(grid_step: int):
	var collision = move_and_collide(Vector2.LEFT * grid_step, true)
	if collision:
		collision_highlight()
	else:
		position.x -= grid_step

func move_up(grid_step: int):
	var collision = move_and_collide(Vector2.UP * grid_step, true)
	if collision:
		collision_highlight()
	else:
		position.y -= grid_step

func move_down(grid_step: int):
	var collision = move_and_collide(Vector2.DOWN * grid_step, true)
	if collision:
		collision_highlight()
	else:
		position.y += grid_step

func collision_highlight():
	var tween = create_tween()
	
	if can_place:
		outline = Color.DARK_RED
		tween.tween_property(self, "outline", original_outline, 0.2)
	else:
		outline = original_outline
		tween.tween_property(self, "outline", Color.DARK_RED, 0.2)

func validate_placing():
	# Stop blinking/strong opacity?
	# Play construction sound
#	print("validate placing")
#	can_place = false
	pass

func cancel_placing():
	queue_free()


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	check_can_place()


func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	check_can_place()
