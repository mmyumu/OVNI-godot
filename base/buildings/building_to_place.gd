@tool
class_name Building extends CharacterBody2D

@export var outline_color: Color = Color("db996a"):
	set(value):
		outline_color = value
		queue_redraw()

@export var outline_width: float = 2.0:
	set(value):
		outline_width = value
		queue_redraw()

@export var color: Color = Color.CADET_BLUE:
	set(value):
		color = value
		queue_redraw()

var template_type: BuildingTemplatesData.Type

var original_outline_color: Color
var can_place: bool
var first
var last_rotation: float

func _ready():
	can_place = true
	first = true
	original_outline_color = outline_color
	
	$DrawableCollisionPolygon2D.color = color
	$DrawableCollisionPolygon2D.outline_color = outline_color
	$DrawableCollisionPolygon2D.outline_width = outline_width
	#$Area2D/CollisionPolygon2D.set_polygon($DrawableCollisionPolygon2D.get_polygon())

func check_can_place():
	if len($Area2D.get_overlapping_areas()) > 0:
		$DrawableCollisionPolygon2D.outline_color = Color.DARK_RED
		can_place = false
	else:
		$DrawableCollisionPolygon2D.outline_color = original_outline_color
		can_place = true
	return can_place

func get_collision_polygon():
	return $DrawableCollisionPolygon2D

func set_placing_mode():
	color.a = 0.5
	# Blink/low opacity?

func move_right(grid_step: int):
	var collision = move_and_collide(Vector2.RIGHT * grid_step, true, 0)
	if collision:
		collision_highlight()
	else:
		position.x += grid_step

func move_left(grid_step: int):
	var collision = move_and_collide(Vector2.LEFT * grid_step, true, 0)
	if collision:
		collision_highlight()
	else:
		position.x -= grid_step

func move_up(grid_step: int):
	var collision = move_and_collide(Vector2.UP * grid_step, true, 0)
	if collision:
		collision_highlight()
	else:
		position.y -= grid_step

func move_down(grid_step: int):
	var collision = move_and_collide(Vector2.DOWN * grid_step, true, 0)
	if collision:
		collision_highlight()
	else:
		position.y += grid_step

func rotate_right():
	var initial_rotation = rotation
	rotation += PI/2
	var collision = move_and_collide(Vector2.ZERO, true, 0)
	if collision:
		rotation = initial_rotation

func rotate_left():
	var initial_rotation = rotation
	rotation -= PI/2
	var collision = move_and_collide(Vector2.ZERO, true, 0)
	if collision:
		rotation = initial_rotation

func collision_highlight():
	var tween = create_tween()
	
	if can_place:
		$DrawableCollisionPolygon2D.outline_color = Color.DARK_RED
		tween.tween_property($DrawableCollisionPolygon2D, "outline_color", original_outline_color, 0.2)
	else:
		$DrawableCollisionPolygon2D.outline_color = original_outline_color
		tween.tween_property($DrawableCollisionPolygon2D, "outline_color", Color.DARK_RED, 0.2)

func validate_placing():
	# Stop blinking/strong opacity?
	# Play construction sound
#	print("validate placing")
#	can_place = false
	pass

func cancel_placing():
	queue_free()


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("wall"):
		print("area_rid=%s, area=%s, area_shape_index=%s, local_shape_index=%s" % [area_rid, area, area_shape_index, local_shape_index])
	check_can_place()


func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	check_can_place()
