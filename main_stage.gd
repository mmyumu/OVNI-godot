class_name MainStage extends Node

var current_enemies = []
var current_spawners = []

func _ready():
	GlobalVariables.player = $Player
	get_tree().paused = true
	update_hud_hp()
	update_hud_money()
	$Player.hide()
	
	for node in get_children():
		if node is BaseSpawner:
			current_spawners.append(node)

func _process(delta):
	check_stage_completed()

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

func start_stop_game(start: bool, game_over:bool = true):
	if start:
		$Player.show()
		start_spawners()
		$HUD/GameOverLabel.hide()
		get_tree().paused = false
	else:
		stop_spawners()
		$Player.hide()
		$HUD/GameOverLabel.show()
		get_tree().paused = true

func start_spawners():
	for spawner in current_spawners:
		spawner.start()

func stop_spawners():
	for spawner in current_spawners:
		spawner.stop()

func _on_player_player_hit(damage):
	update_hud_hp()

func _on_spawner_enemy_spawned(enemy):
	current_enemies.append(enemy)
	add_child(enemy)
	enemy.shoot.connect(_on_enemy_shoot)
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
	
func get_spawned_enemies():
	var spawned_enemies = []
	for current_enemy in current_enemies:
		if is_instance_valid(current_enemy):
			spawned_enemies.append(current_enemy)

	return spawned_enemies

func spawning_over():
	for spawner in current_spawners:
		if spawner.spawning:
			return false
	return true

func spawning_cleared():
	return spawning_over() and len(get_spawned_enemies()) == 0

func check_stage_completed():
	if spawning_cleared():
		$HUD/StageCompletedLabel.show()
		$Player.invulnerable = true
		
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://menu.tscn")

