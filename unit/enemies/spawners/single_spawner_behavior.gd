extends Node

signal spawn_triggered(spawn_position)
signal over()

func _ready():
	pass

func _process(delta):
	pass

func set_polygon(polygon):
	$BoundariesUtil.set_boundaries(polygon)

func start():
	$SpawnTimer.start()

func stop():
	$SpawnTimer.stop()

func _on_spawn_timer_timeout():
	var spawn_position = $BoundariesUtil.get_random_position()
	spawn_triggered.emit(spawn_position)
