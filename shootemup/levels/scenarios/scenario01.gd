extends Scenario

func _ready():
	super._ready()

func _process(delta):
	super._process(delta)
	if $TrackerSpawner.is_depleted():
		$TrackerSpawner2.start()
		
	if $TrackerSpawner2.is_depleted():
		scenario_completed.emit()
	
func start():
	$TrackerSpawner.start(true)

func stop():
	pass
