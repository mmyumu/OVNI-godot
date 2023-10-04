extends Node

var rng = RandomNumberGenerator.new()
var enemy_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	update_hp()
	$Player.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_hp()

func _on_player_shoot(projectile, direction, location):
	var spawned_projectile = projectile.instantiate()
	add_child(spawned_projectile)
	spawned_projectile.add_to_group("Player")
	spawned_projectile.get_node("ProjectileShape").color = Color(0, 0, 255, 0.5)
	spawned_projectile.rotation = direction
	spawned_projectile.position = location
	spawned_projectile.velocity = spawned_projectile.velocity.rotated(direction)

func update_hp():
	$HUD/HP/HPLabel.text = str($Player.hp)
	$HUD/HP/MaxHPLabel.text = str($Player.max_hp)

func _on_hud_start_play():
	$Player.show()
	$Spawner/SpawnTimer.start()
	get_tree().paused = false


func _on_spawn_timer_timeout():
	# TODO: improve spawn position (outside of screen? not on player?)
	# TODO: spawn waves of enemies instead of enemies 1 by 1 (scripted? random mechanism?)
	var x = rng.randi_range(0, GlobalVariables.screen_size.x)
	var y = rng.randi_range(0, GlobalVariables.screen_size.y/2)
	var spawn_position = Vector2(x, y)
	var enemy = $Spawner.spawn(spawn_position, enemy_index)
	
	enemy.shoot.connect(_on_enemy_shoot)
	
	enemy_index += 1
	
func _on_enemy_shoot(projectile, direction, location):
	print("main_stage _on_enemy_shoot")
	var spawned_projectile = projectile.instantiate()
	add_child(spawned_projectile)
	spawned_projectile.add_to_group("Enemies")
	spawned_projectile.get_node("ProjectileShape").color = Color(255, 0, 0, 0.5)
	spawned_projectile.speed = 200
	spawned_projectile.rotation = direction
	spawned_projectile.position = location
	spawned_projectile.velocity = spawned_projectile.velocity.rotated(direction)
	print("direction: ", direction)
