extends Node2D

var rng = RandomNumberGenerator.new()
var min_point
var max_point

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_boundaries(polygon):
	var min_x
	var max_x
	var min_y
	var max_y
	
	for p in polygon:
		if min_x == null:
			min_x = p.x
		if max_x == null:
			max_x = p.x
		if min_y == null:
			min_y = p.y
		if max_y == null:
			max_y = p.y

		if p.x < min_x:
			min_x = p.x
		if p.x > max_x:
			max_x = p.x
		if p.y < min_y:
			min_y = p.y
		if p.y > max_y:
			max_y = p.y

	var local_min_point = Vector2(min_x, min_y)
	var local_max_point = Vector2(max_x, max_y)
	min_point = to_global(local_min_point)
	max_point = to_global(local_max_point)
	
	print("position: %s, global_position: %s, local_min: %s, global_min: %s, local_max: %s, global_max: %s" % [position, global_position, local_min_point, min_point, local_max_point, max_point])

func get_random_position():
	var x = rng.randi_range(min_point.x, max_point.x)
	var y = rng.randi_range(min_point.y, max_point.y)
	return Vector2(x, y)
