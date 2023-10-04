extends Marker2D

signal shoot(projectile, direction, location)

var projectile = preload("res://unit/projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_shoot_timer_timeout():
#	print("weapon _on_shoot_timer_timeout")
	shoot.emit(projectile, $CannonMouth.global_rotation, $CannonMouth.global_position)
