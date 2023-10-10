extends Polygon2D

var rng = RandomNumberGenerator.new()

var enemy = preload("res://unit/enemies/enemy.tscn")

var min_point
var max_point

var enemy_index = 0

signal enemy_spawned(enemy)

func _ready():
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

	min_point = to_global(Vector2(min_x, min_y))
	max_point = to_global(Vector2(max_x, max_y))
	
	print("min_x=%s, max_x=%s, min_y=%s, max_y=%s" % [min_x, max_x, min_y, max_y])

func _process(delta):
	pass

func start():
	$SpawnTimer.start()
	$SpawnWaveTimer.start()

func stop():
	$SpawnTimer.stop()
	$SpawnWaveTimer.stop()

func get_random_position():
	var x = rng.randi_range(min_point.x, max_point.x)
	var y = rng.randi_range(min_point.y, max_point.y)
	return Vector2(x, y)

func spawn_random():
	return spawn(get_random_position())
	
func spawn(spawn_position):
	var enemy_name = "Enemy%s" % enemy_index
	
	var spawned_enemy = enemy.instantiate()
	spawned_enemy.name = enemy_name
	spawned_enemy.position = spawn_position
	spawned_enemy.rotation = TAU/2
	
	enemy_spawned.emit(spawned_enemy)
	enemy_index += 1
	return spawned_enemy

func spawn_wave(number_of_enemies):
	var x_offset = 50
	var y_offset = 50
	var spawned_enemies = []
#	var spawned_enemy = spawn_random()
#	var spawned_position = Vector2(spawned_enemy.position)
#	spawned_enemies.append(spawned_enemy)

	var spawned_position
	
	for i in range(number_of_enemies):
		if i > 0:
			await get_tree().create_timer(0.1).timeout

		if spawned_position == null:
			spawned_position = get_random_position()
		
		var spawn_position = Vector2(spawned_position.x - x_offset, spawned_position.y - y_offset)
		var spawned_enemy = spawn(spawn_position)
		
		spawned_position = Vector2(spawned_enemy.position)
		spawned_enemies.append(spawned_enemy)
	
	return spawned_enemies

func _on_spawn_timer_timeout():
	spawn_random()

func _on_spawn_wave_timer_timeout():
	spawn_wave(3)
