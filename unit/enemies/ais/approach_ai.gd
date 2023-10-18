extends AI

@export var approach_speed: float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func compute(delta, enemy):
	enemy.position = lerp(enemy.global_position, GlobalVariables.player.global_position, approach_speed * delta)
