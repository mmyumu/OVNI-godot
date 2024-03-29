@tool
extends Sprite2D

@export var placing_input_timeout: float = 0.1

var building_base_info_panel_scene: PackedScene = preload("res://base/panels/building_base_info_panel.tscn")
var building_base_info_panel

var base_layout
var deadzone: float = 0.5
var is_placing: bool = false
var can_use_placing_input: bool = true
var building_to_place: BuildingToPlace
var width
var height
var grid_step
var wall_size

signal placing_over()


func _ready():
	$PlaceBuildingDialog.close()
	
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
			building_to_place.rotate_right()
		elif event.is_action_pressed("rotate_left"):
			building_to_place.rotate_left()
		elif event.is_action_pressed("cancel"):
			building_to_place.cancel_placing()
			is_placing = false
			placing_over.emit()
			get_viewport().set_input_as_handled()

func _placing_input():
	var v_x = Input.get_axis("move_left", "move_right")
	var v_y = Input.get_axis("move_up", "move_down")
	
	if abs(v_x) or abs(v_y) > deadzone:
		if abs(v_x) > abs(v_y):
			if v_x > 0:
				building_to_place.move_right(grid_step)
				lock_placing_input()
			elif v_x < 0:
				building_to_place.move_left(grid_step)
				lock_placing_input()
		elif abs(v_y) > abs(v_x):
			if v_y > 0:
				building_to_place.move_down(grid_step)				
				lock_placing_input()
			elif v_y < 0:
				building_to_place.move_up(grid_step)
				lock_placing_input()

func validate_placing():
	if building_to_place.check_can_place():
		$PlaceBuildingDialog.open(building_to_place)
	else:
		building_to_place.collision_highlight()

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

func create_west_wall():
	var size_y = height * grid_step
	$Walls/WestWallCollisionShape2D.set_shape(create_wall(wall_size, size_y))
	$Walls/WestWallCollisionShape2D.position.x = wall_size + -wall_size/2 - 1
	$Walls/WestWallCollisionShape2D.position.y = wall_size + height * grid_step / 2

func create_north_wall():
	var size_x = width * grid_step
	$Walls/NorthWallCollisionShape2D.set_shape(create_wall(size_x, wall_size))
	$Walls/NorthWallCollisionShape2D.position.x = wall_size + width * grid_step / 2
	$Walls/NorthWallCollisionShape2D.position.y = wall_size + -wall_size/2 - 1

func create_south_wall():
	var size_x = width * grid_step
	$Walls/SouthWallCollisionShape2D.set_shape(create_wall(size_x, wall_size))
	$Walls/SouthWallCollisionShape2D.position.x = wall_size + width * grid_step / 2
	$Walls/SouthWallCollisionShape2D.position.y = wall_size + height * grid_step + wall_size/2 + 1
	
func create_wall(size_x, size_y):
	var wall = RectangleShape2D.new()
	wall.size.x = size_x
	wall.size.y = size_y
	return wall

func set_placing(_building_to_place: BuildingToPlace):
	if building_to_place and is_instance_valid(building_to_place):
		building_to_place.cancel_placing()
	$BaseGrid.set_placing(_building_to_place)
	building_to_place = _building_to_place
	is_placing = true

func lock_placing_input():
	can_use_placing_input = false
	$PlacingInputTimer.start()

func _on_placing_input_timer_timeout():
	can_use_placing_input = true

func _on_place_building_dialog_confirmed():
	var building = Building.new()
	building.location = $BaseGrid.get_location(building_to_place)
	building.rotation = building_to_place.rotation
	building.template_type = building_to_place.template_type

	var result = Headquarters.start_building_construction(Global.get_current_base(), building)

	if result:
		$BaseGrid.add_building(building, building_to_place)
		building_to_place.validate_placing()
	get_tree().paused = false

func show_building_info(building: Building, base: Base):
	building_base_info_panel = building_base_info_panel_scene.instantiate()
	building_base_info_panel.building = building
	add_child(building_base_info_panel)

func hide_building_info(building: Building, base: Base):
	if building_base_info_panel:
		building_base_info_panel.queue_free()
