class_name Spawner extends Polygon2D

@export var enemies_scenes: Array[PackedScene]

var behaviors = []
var current_enemies: Array[Node] = []
var enemy_index = 0
var spawn_wave_counter = 0
var spawning = true

signal enemy_spawned(enemy)


func _ready():
	for child in get_children():
		if child.is_in_group("Behavior"):
			behaviors.append(child)
			child.set_polygon(polygon)	

func _process(delta):
	pass

func start():
	spawning = true
	for behavior in behaviors:
		behavior.start()

func stop():
	spawning = false
	for behavior in behaviors:
		behavior.stop()

func _on_spawn_triggered(spawn_position):
	spawn(spawn_position)

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

func is_over():
	for behavior in behaviors:
		if not behavior.is_over():
			return false
	return true
