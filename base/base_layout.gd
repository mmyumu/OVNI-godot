@tool
extends Sprite2D

@export var placing_input_timeout: float = 0.1

var base_layout
var deadzone: float = 0.5
var is_placing: bool = false
var can_use_placing_input: bool = true
var construction: Construction
var width
var height
var grid_step
var wall_size

signal placing_over()


func _ready():
	width = $BaseGrid.width
	height = $BaseGrid.height
	grid_step = $BaseGrid.grid_step
	wall_size = grid_step
	
	base_layout = create_map(20, 15)
	create_walls()
	$PlacingInputTimer.wait_time = placing_input_timeout
	
	$Walls.position.x = (texture.get_width() - $BaseGrid.get_width()) / 2 - position.x - wall_size
	$Walls.position.y = (texture.get_height() - $BaseGrid.get_height()) / 2 - position.y - wall_size
	
	$BaseGrid.position.x = (texture.get_width() - $BaseGrid.get_width()) / 2 - position.x
	$BaseGrid.position.y = (texture.get_height() - $BaseGrid.get_height()) / 2 - position.y

func _process(delta):
	if is_placing and can_use_placing_input:
		_placing_input()

func _input(event):
	if is_placing:
		if event.is_action_pressed("validate"):
			validate_placing()
		elif event.is_action_pressed("rotate_right"):
			construction.rotate_right()
		elif event.is_action_pressed("rotate_left"):
			construction.rotate_left()
		elif event.is_action_pressed("cancel"):
			construction.cancel_placing()
			is_placing = false
			placing_over.emit()
			get_viewport().set_input_as_handled()

func _placing_input():
	var v_x = Input.get_axis("move_left", "move_right")
	var v_y = Input.get_axis("move_up", "move_down")
	
	if abs(v_x) or abs(v_y) > deadzone:
		if abs(v_x) > abs(v_y):
			if v_x > 0:
				construction.move_right(grid_step)
				lock_placing_input()
			elif v_x < 0:
				construction.move_left(grid_step)
				lock_placing_input()
		elif abs(v_y) > abs(v_x):
			if v_y > 0:
				construction.move_down(grid_step)				
				lock_placing_input()
			elif v_y < 0:
				construction.move_up(grid_step)
				lock_placing_input()

func validate_placing():
	$BaseGrid.validate_placing(construction)
	construction.validate_placing()

func create_map(w, h):
	var map = []

	for x in range(w):
		var col = []
		col.resize(h)
		map.append(col)

	return map

func create_walls():
	create_east_wall()
	create_west_wall()
	create_north_wall()
	create_south_wall()
	
func create_east_wall():
	var size_y = height * grid_step
	$Walls/EastWallCollisionShape2D.set_shape(create_wall(wall_size, size_y))
	$Walls/EastWallCollisionShape2D.position.x = wall_size + width * grid_step + wall_size/2 + 1
	$Walls/EastWallCollisionShape2D.position.y = wall_size + height * grid_step / 2
	
	$Area2D/EastWallCollisionShape2D.set_shape(create_wall(wall_size, size_y))
	$Area2D/EastWallCollisionShape2D.position.x = wall_size + width * grid_step + wall_size/2 + 1
	$Area2D/EastWallCollisionShape2D.position.y = wall_size + height * grid_step / 2

func create_west_wall():
	var size_y = height * grid_step
	$Walls/WestWallCollisionShape2D.set_shape(create_wall(wall_size, size_y))
	$Walls/WestWallCollisionShape2D.position.x = wall_size + -wall_size/2 - 1
	$Walls/WestWallCollisionShape2D.position.y = wall_size + height * grid_step / 2
	
	$Area2D/WestWallCollisionShape2D.set_shape(create_wall(wall_size, size_y))
	$Area2D/WestWallCollisionShape2D.position.x = wall_size + -wall_size/2 - 1
	$Area2D/WestWallCollisionShape2D.position.y = wall_size + height * grid_step / 2

func create_north_wall():
	var size_x = width * grid_step
	$Walls/NorthWallCollisionShape2D.set_shape(create_wall(size_x, wall_size))
	$Walls/NorthWallCollisionShape2D.position.x = wall_size + width * grid_step / 2
	$Walls/NorthWallCollisionShape2D.position.y = wall_size + -wall_size/2 - 1

	$Area2D/NorthWallCollisionShape2D.set_shape(create_wall(size_x, wall_size))
	$Area2D/NorthWallCollisionShape2D.position.x = wall_size + width * grid_step / 2
	$Area2D/NorthWallCollisionShape2D.position.y = wall_size + -wall_size/2 - 1

func create_south_wall():
	var size_x = width * grid_step
	$Walls/SouthWallCollisionShape2D.set_shape(create_wall(size_x, wall_size))
	$Walls/SouthWallCollisionShape2D.position.x = wall_size + width * grid_step / 2
	$Walls/SouthWallCollisionShape2D.position.y = wall_size + height * grid_step + wall_size/2 + 1

	$Area2D/SouthWallCollisionShape2D.set_shape(create_wall(size_x, wall_size))
	$Area2D/SouthWallCollisionShape2D.position.x = wall_size + width * grid_step / 2
	$Area2D/SouthWallCollisionShape2D.position.y = wall_size + height * grid_step + wall_size/2 + 1
	
func create_wall(size_x, size_y):
	var wall = RectangleShape2D.new()
	wall.size.x = size_x
	wall.size.y = size_y
	return wall

func set_placing(construction_to_place: Construction):
	if construction and is_instance_valid(construction):
		construction.cancel_placing()
	$BaseGrid.set_placing(construction_to_place)
	construction = construction_to_place
	is_placing = true

func lock_placing_input():
	can_use_placing_input = false
	$PlacingInputTimer.start()

func _on_placing_input_timer_timeout():
	can_use_placing_input = true
