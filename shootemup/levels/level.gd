class_name Level extends Node2D

signal enemy_spawned(enemy)

func _on_enemy_spawned(enemy):
	enemy_spawned.emit(enemy)
