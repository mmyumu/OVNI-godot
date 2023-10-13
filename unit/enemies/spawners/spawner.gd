class_name Spawner extends Polygon2D

@export var enemies_scenes: Array[PackedScene]
#@export var max_wave_count = 3
@export var behavior_scene: PackedScene

var current_enemies: Array[Node] = []
var behavior
var enemy_index = 0
var spawn_wave_counter = 0
var spawning = true

signal enemy_spawned(enemy)

func _ready():
	behavior = behavior_scene.instantiate()
	behavior.spawn_triggered.connect(_on_spawn_triggered)
	behavior.set_polygon(polygon)
	add_child(behavior)
#	set_boundaries()
	
#func set_boundaries():
#	var min_x
#	var max_x
#	var min_y
#	var max_y
#
#	for p in polygon:
#		if min_x == null:
#			min_x = p.x
#		if max_x == null:
#			max_x = p.x
#		if min_y == null:
#			min_y = p.y
#		if max_y == null:
#			max_y = p.y
#
#		if p.x < min_x:
#			min_x = p.x
#		if p.x > max_x:
#			max_x = p.x
#		if p.y < min_y:
#			min_y = p.y
#		if p.y > max_y:
#			max_y = p.y
#
#	min_point = to_global(Vector2(min_x, min_y))
#	max_point = to_global(Vector2(max_x, max_y))
#
#	print("min_x=%s, max_x=%s, min_y=%s, max_y=%s" % [min_x, max_x, min_y, max_y])

func _process(delta):
	pass

func start():
	spawning = true
	behavior.start()

func stop():
	spawning = false
	behavior.stop()

func _on_spawn_triggered(spawn_position):
	spawn(spawn_position)

#func spawn_random():
#	return spawn(get_random_position())

func spawn(spawn_position):
	var enemy_name = "Enemy%s" % enemy_index
	
	if len(enemies_scenes) <= 0:
		return
	
	var enemy_scene = enemies_scenes[randi() % len(enemies_scenes)]
	var spawned_enemy = enemy_scene.instantiate()
	spawned_enemy.name = enemy_name
	spawned_enemy.position = spawn_position
	spawned_enemy.rotation = TAU/2
	
	enemy_spawned.emit(spawned_enemy)
	enemy_index += 1
	
	current_enemies.append(spawned_enemy)
	return spawned_enemy

#func spawn_wave(number_of_enemies):
#	var x_offset = 50
#	var y_offset = 50
#	var spawned_enemies = []
#	var spawned_position
#
#	for i in range(number_of_enemies):
#		if i > 0:
#			await get_tree().create_timer(0.1).timeout
#
#		if spawned_position == null:
#			spawned_position = get_random_position()
#
#		var spawn_position = Vector2(spawned_position.x - x_offset, spawned_position.y - y_offset)
#		var spawned_enemy = spawn(spawn_position)
#
#		spawned_position = Vector2(spawned_enemy.position)
#		spawned_enemies.append(spawned_enemy)
#
#	spawn_wave_counter += 1
#
#	return spawned_enemies

#func _on_spawn_timer_timeout():
#	spawn_random()

#func _on_spawn_wave_timer_timeout():
#	spawn_wave(3)
#	if spawn_wave_counter >= max_wave_count:
#		stop_spawning()

#func stop_spawning():
#	$SpawnTimer.stop()
#	$SpawnWaveTimer.stop()

#func spawning_over():
#	return spawn_wave_counter >= max_wave_count
