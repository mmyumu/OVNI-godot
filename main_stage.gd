extends Node

var enemy_index = 0

func _ready():
	GlobalVariables.player = $Player
	get_tree().paused = true
	update_hp()
	$Player.hide()

func _process(delta):
#	update_hp()
	pass

func _on_player_shoot(projectile, direction, location):
	var spawned_projectile = projectile.instantiate()
	add_child(spawned_projectile)
	spawned_projectile.add_to_group("Player")
	spawned_projectile.get_node("ProjectileShape").color = Color(0, 0, 255, 0.5)
	spawned_projectile.rotation = direction
	spawned_projectile.position = location
	spawned_projectile.velocity = spawned_projectile.velocity.rotated(direction)

func update_hp():
	if $Player:
		$HUD/HP/HPLabel.text = str($Player.hp)
		$HUD/HP/MaxHPLabel.text = str($Player.max_hp)

func _on_hud_start_play():
	start_stop_game(true)

func _on_spawn_timer_timeout():
	# TODO: improve spawn position (outside of screen? not on player?)
	# TODO: spawn waves of enemies instead of enemies 1 by 1 (scripted? random mechanism?)
	var enemy = $Spawner.spawn(enemy_index)
	enemy.shoot.connect(_on_enemy_shoot)
	enemy_index += 1
	
func _on_enemy_shoot(projectile, direction, location):
	var spawned_projectile = projectile.instantiate()
	add_child(spawned_projectile)
	spawned_projectile.add_to_group("Enemies")
	spawned_projectile.get_node("ProjectileShape").color = Color(255, 0, 0, 0.5)
	spawned_projectile.speed = 200
	spawned_projectile.rotation = direction
	spawned_projectile.position = location
	spawned_projectile.velocity = spawned_projectile.velocity.rotated(direction)


func _on_player_game_over():
	start_stop_game(false)
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://menu.tscn")

func start_stop_game(start):
	if start:
		$Player.show()
		$Spawner/SpawnTimer.start()
		$HUD/GameOverLabel.hide()
		get_tree().paused = false
	else:
		$Player.hide()
		$Spawner/SpawnTimer.stop()
		$HUD/GameOverLabel.show()
		get_tree().paused = true


func _on_player_player_hit(damage):
	update_hp()
