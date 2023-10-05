extends Polygon2D

@export var rotation_speed = 5
@export var fire_rate: float = 2 # Fire/second - TODO: should be computed from player fire_rate and specific projectile fire_rate

var last_fire: float = 0.
#var rotation_direction = 0
var rs_look = Vector2.ZERO
var deadzone = 0.3
var previous_rs_look

var projectile = preload("res://unit/projectile1.tscn")


signal shoot(projectile, direction, location)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rs_look.y = Input.get_joy_axis(0, JOY_AXIS_RIGHT_X)
	rs_look.x = -Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)
	if rs_look.length() >= deadzone:
		rotation = lerp_angle(rotation, rs_look.angle(), 0.05)
	check_shoot(delta)


func check_shoot(delta: float):
	var fire_delay = 1/fire_rate
	last_fire -= delta
	if last_fire < 0 and Input.is_action_pressed("shoot"):
		shoot.emit(projectile, rotation, $CannonMouth.global_position)
		last_fire = fire_delay
