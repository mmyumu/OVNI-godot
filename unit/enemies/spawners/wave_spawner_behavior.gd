extends Node2D

var spawn_wave_counter = 0

signal spawn_triggered(spawn_position)
signal over()

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func set_polygon(polygon):
	$BoundariesUtil.set_boundaries(polygon)

func spawn_wave(number_of_enemies):
	var x_offset = 50
	var y_offset = 50
	var spawned_enemies = []
	var spawned_position

	for i in range(number_of_enemies):
		if i > 0:
			await get_tree().create_timer(0.1).timeout

		if spawned_position == null:
			spawned_position = $BoundariesUtil.get_random_position()

		var spawn_position = Vector2(spawned_position.x - x_offset, spawned_position.y - y_offset)
		spawn_triggered.emit(spawn_position)

		spawned_position = spawn_position

	spawn_wave_counter += 1

	return spawned_enemies
