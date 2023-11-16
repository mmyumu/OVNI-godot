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

func _ready():
	original_outline = outline

func _draw():
	var poly = $CollisionPolygon2D.get_polygon()
	for i in range(1 , poly.size()):
		draw_line(poly[i-1] , poly[i], outline , width)
	draw_line(poly[poly.size() - 1] , poly[0], outline , width)
	draw_polygon(poly, PackedColorArray([color]))

func set_placing_mode():
	color.a = 0.5
	# Blink/low opacity?
	print("placing mode enabled")

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
	outline = Color.DARK_RED
	tween.tween_property(self, "outline", original_outline, 0.2)
	print("tweenie from %s to %s" % [outline, original_outline])

func validate_placing():
	# Stop blinking/strong opacity?
	# Play construction sound
	print("validate placing")

func cancel_placing():
	queue_free()

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("collision")
