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

@export var placing_input_timeout: float = 0.1

var base_layout
var deadzone: float = 0.5
var is_placing: bool = false
var can_use_placing_input: bool = true
var construction: Construction

signal placing_over()


func _ready():
	base_layout = create_map(20, 15)
	$PlacingInputTimer.wait_time = placing_input_timeout

func _draw():
	draw_grid()

func _process(delta):
	if is_placing and can_use_placing_input:
		_placing_input()

func _placing_input():
	var v_x = Input.get_axis("move_left", "move_right")
	var v_y = Input.get_axis("move_up", "move_down")
	
	if abs(v_x) or abs(v_y) > deadzone:
		if abs(v_x) > abs(v_y):
			if v_x > 0:
				construction.move_right(width, height, grid_step)
				lock_placing_input()
			elif v_x < 0:
				construction.move_left(width, height, grid_step)
				lock_placing_input()
		elif abs(v_y) > abs(v_x):
			if v_y > 0:
				construction.move_down(width, height, grid_step)				
				lock_placing_input()
			elif v_y < 0:
				construction.move_up(width, height, grid_step)
				lock_placing_input()

func _input(event):
	if is_placing:
		if event.is_action_pressed("validate_placing"):
			construction.validate_placing(grid_step)
		elif event.is_action_pressed("cancel_placing"):
			construction.cancel_placing()
			is_placing = false
			placing_over.emit()

func draw_grid():
	draw_horizontal_lines()
	draw_vertical_lines()

func draw_horizontal_lines():
#	pass
	for y in range(0, height + 1, grid_step):
		draw_line(Vector2(0, y), Vector2(width, y), color, thickness)
		
func draw_vertical_lines():
#	pass
	for x in range(0, width + 1, grid_step):
		draw_line(Vector2(x, 0), Vector2(x, height), color, thickness)

func set_placing(construction_to_place: Construction):
	construction = construction_to_place
	is_placing = true
	add_child(construction_to_place)

func lock_placing_input():
	can_use_placing_input = false
	$PlacingInputTimer.start()

func _on_input_timer_timeout():
	can_use_placing_input = true

func create_map(w, h):
	var map = []

	for x in range(w):
		var col = []
		col.resize(h)
		map.append(col)

	return map
