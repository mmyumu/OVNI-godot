extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	update_hp()
	$Player.hide()
#	$StartTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	$HUD.update_start_play()


func _on_player_shoot(projectile, direction, location):
	var spawned_projectile = projectile.instantiate()
	add_child(spawned_projectile)
	spawned_projectile.rotation = direction
	spawned_projectile.position = location
	spawned_projectile.velocity = spawned_projectile.velocity.rotated(direction)

func update_hp():
	$HUD/HP/HPLabel.text = str($Player.hp)
	$HUD/HP/MaxHPLabel.text = str($Player.max_hp)


#func _on_start_timer_timeout():
#	$HUD.start_play()


func _on_hud_start_play():
	$Player.show()
	get_tree().paused = false
