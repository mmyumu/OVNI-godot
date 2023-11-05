extends Node3D

# Vitesse de rotation du globe
var rotation_speed = 0.5

func _ready():
	pass

func _process(delta):
	var rotation_y = 0

	if Input.is_key_pressed(KEY_RIGHT):
		rotation_y += rotation_speed * delta
	if Input.is_key_pressed(KEY_LEFT):
		rotation_y -= rotation_speed * delta

	$MeshInstance3D.rotate_y(rotation_y)
