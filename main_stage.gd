extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_shoot(projectile, direction, location):
	var spawned_projectile = projectile.instantiate()
	add_child(spawned_projectile)
	spawned_projectile.rotation = direction
	spawned_projectile.position = location
	spawned_projectile.velocity = spawned_projectile.velocity.rotated(direction)
