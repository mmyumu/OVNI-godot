extends Scenario

var step = -1

func _ready():
	super._ready()

func _process(delta):
	super._process(delta)
	
	if step == 0:
		$FighterSpawnerLeft.start()
		$FighterSpawnerRight.start()
		
		if $FighterSpawnerLeft.is_depleted() and $FighterSpawnerRight.is_depleted():
			set_step(1)
			$FighterSpawnerLeft.restart()
			$FighterSpawnerRight.restart()
	elif step == 1:
		if $FighterSpawnerLeft.is_depleted() and $FighterSpawnerRight.is_depleted():
			scenario_completed.emit()
	
func start():
	set_step(0)

func stop():
	pass

func set_step(step_number):
	step = step_number
	print("Scenario: %s -> set step to %s" % [name, step])
