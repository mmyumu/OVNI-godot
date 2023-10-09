extends Node

var enemy_index = 0

func _ready():
	GlobalVariables.player = $Player
	get_tree().paused = true
	update_hud_hp()
	update_hud_money()
	$Player.hide()

func _process(delta):
	pass

func _on_player_shoot(projectile, direction, location):
	var spawned_projectile = projectile.instantiate()
	add_child(spawned_projectile)
	spawned_projectile.add_to_group("Player")
	spawned_projectile.get_node("ProjectileShape").color = Color(0, 0, 255, 0.5)
	spawned_projectile.rotation = direction
	spawned_projectile.position = location
	spawned_projectile.velocity = spawned_projectile.velocity.rotated(direction)

func update_hud_hp():
	if $Player:
		$HUD/HP/HPLabel.text = str(max($Player.hp, 0))
		$HUD/HP/MaxHPLabel.text = str($Player.max_hp)

func update_hud_money():
	if $Player:
		$HUD/Money.text = "%s $" % str($Player.money)

func _on_hud_start_play():
	start_stop_game(true)
	
func _on_enemy_shoot(projectile, direction, location):
	var spawned_projectile = projectile.instantiate()
	add_child(spawned_projectile)
	spawned_projectile.add_to_group("Enemies")
	spawned_projectile.get_node("ProjectileShape").color = Color(255, 0, 0, 0.5)
	spawned_projectile.rotation = direction
	spawned_projectile.position = location
	spawned_projectile.velocity = spawned_projectile.velocity.rotated(direction)

func _on_enemy_destroyed(enemy):
	GlobalVariables.player.money += enemy.money
	update_hud_money()

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
	update_hud_hp()

func _on_spawner_enemy_spawned(enemy):
	add_child(enemy)
	enemy.shoot.connect(_on_enemy_shoot)
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
