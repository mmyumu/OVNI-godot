extends Node3D

@export var rotation_speed: float = 1

var deadzone = 0.3
var initial_rotation
func _ready():
	initial_rotation = Vector2($CameraGimbal/InnerGimbal.rotation.x, $CameraGimbal.rotation.y)
	$CameraGimbal/InnerGimbal/Camera3D.look_at($MeshInstance3D.position)

func _process(delta):
	var rs_look = Vector3.ZERO
	rs_look.y = Input.get_joy_axis(0, JOY_AXIS_RIGHT_X)
	rs_look.x = Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)

	if rs_look.length() > deadzone:
		$CameraGimbal.rotate_y(rs_look.y * delta * rotation_speed)
		$CameraGimbal/InnerGimbal.rotate_x(rs_look.x * delta * rotation_speed)
		
		$CameraGimbal/InnerGimbal.rotation.x = clamp($CameraGimbal/InnerGimbal.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _input(event):
	if event.is_action_pressed("earth_center"):
		var tween1 = create_tween()
		var tween2 = create_tween()
		tween1.tween_property($CameraGimbal/InnerGimbal, "rotation", Vector3(initial_rotation.x, 0., 0.), 0.1)
		tween2.tween_property($CameraGimbal, "rotation", Vector3(0., initial_rotation.y, 0.), 0.1)
