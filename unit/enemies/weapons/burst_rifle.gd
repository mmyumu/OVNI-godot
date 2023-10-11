extends Marker2D

signal shoot(projectile, direction, location)

@export var projectile = preload("res://unit/projectiles/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_shoot_timer_timeout():
	shoot.emit(projectile, global_rotation, global_position)
	await get_tree().create_timer(0.2).timeout
	shoot.emit(projectile, global_rotation, global_position)
	await get_tree().create_timer(0.2).timeout
	shoot.emit(projectile, global_rotation, global_position)


func _on_visible_on_screen_notifier_2d_screen_entered():
	$ShootTimer.start()
