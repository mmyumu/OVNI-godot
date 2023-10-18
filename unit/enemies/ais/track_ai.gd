extends AI


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func compute(delta, enemy):
	var v = enemy.global_position - GlobalVariables.player.global_position
	var angle = v.angle() - PI/2

	enemy.rotation = lerp_angle(enemy.global_rotation, angle, 2 * delta)
