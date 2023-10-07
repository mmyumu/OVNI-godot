extends Node

@export var approach_speed = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func compute_position(delta, current_position):
	return lerp(current_position, GlobalVariables.player.position, approach_speed * delta)
