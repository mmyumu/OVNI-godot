extends Node

signal spawn_triggered(spawn_position)
signal over()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start():
	$SpawnTimer.start()

func stop():
	$SpawnTimer.stop()

func _on_spawn_timer_timeout():
	spawn_triggered.emit(null)
