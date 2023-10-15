extends Node

@export var approach_speed = 0.1

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func compute_position(delta, current_position):
	return lerp(current_position, GlobalVariables.player.position, approach_speed * delta)

func compute_rotation(delta, enemy):
	var v = enemy.global_position - GlobalVariables.player.global_position
	var angle = v.angle() - PI/2
	
#	rs_look.y = Input.get_joy_axis(0, JOY_AXIS_RIGHT_X)
#	rs_look.x = -Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)
#	if rs_look.length() >= deadzone:
#		rotation = lerp_angle(rotation, rs_look.angle(), 5 * delta)
	
#	look_at()
	return lerp_angle(enemy.global_rotation, angle, 2 * delta)
#	return lerp_angle(enemy.global_rotation, GlobalVariables.player.global_position.angle_to(enemy.global_position), 10 * delta)
