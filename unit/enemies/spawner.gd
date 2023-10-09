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

func spawn(enemy_index):
	var x = rng.randi_range(min_point.x, max_point.x)
	var y = rng.randi_range(min_point.y, max_point.y)
	var spawn_position = Vector2(x, y)
	var spawned_enemy = enemy.instantiate()
	spawned_enemy.name = "Enemy%s" % enemy_index
	spawned_enemy.position = spawn_position
	spawned_enemy.rotation = TAU/2
#	print("Spawned enemy %s at x=%s, y=%s" % [spawned_enemy.name, spawn_position.x, spawn_position.y])
	
	enemy_spawned.emit(spawned_enemy)
	
	return spawned_enemy


func _on_spawn_timer_timeout():
	spawn(enemy_index)
	enemy_index += 1
