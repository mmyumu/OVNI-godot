class_name LevelLoader extends Node2D

@export var levels: Array[PackedScene]

var current_level: Level

signal enemy_spawned(enemy)

func _ready():
	current_level = self.instantiate_level()
	current_level.enemy_spawned.connect(_on_enemy_spawned)
	add_child(current_level)

func instantiate_level():
	randomize()
	var level_index: int = randi() % levels.size()
	return levels[level_index].instantiate()

func get_spawners():
	var current_spawners = []
	for node in current_level.get_children():
		if node is Spawner:
			current_spawners.append(node)
	return current_spawners

func _on_enemy_spawned(enemy):
	enemy_spawned.emit(enemy)
