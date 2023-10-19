extends Node2D

@export_range(0, 10, 0.01) var spawn_period: float = 1
@export var wave_count: int = 3
@export_range(0, 100) var wave_size: int = 3

var spawned_wave_counter = 0

signal spawn_triggered(spawn_position)


func _ready():
	$SpawnTimer.wait_time = spawn_period

func _process(delta):
	pass

func set_polygon(polygon):
	$BoundariesUtil.set_boundaries(polygon)

func start():
	$SpawnTimer.start()

func stop():
	$SpawnTimer.stop()

func is_over():
	return spawned_wave_counter >= wave_count

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

	spawned_wave_counter += 1
	
	if wave_count > 0 and is_over():
		stop()

	return spawned_enemies


func _on_spawn_timer_timeout():
	spawn_wave(wave_size)
