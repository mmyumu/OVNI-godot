extends Node

@export var speed: float = 0.02

var rng = RandomNumberGenerator.new()

func _ready():
	Datetimer.day_changed.connect(_on_day_changed)

func _process(delta):
	if not Saver.data.mastermind.destination:
		Saver.data.mastermind.destination = _get_random_earth_position()
		print("Init destination %s" % Saver.data.mastermind.destination)
		
	if abs(Saver.data.mastermind.location.x - Saver.data.mastermind.destination.x) < 1 and \
	 abs(Saver.data.mastermind.location.y - Saver.data.mastermind.destination.y) < 1:
		print("Reached destination %s" % Saver.data.mastermind.destination)
		Saver.data.mastermind.destination = _get_random_earth_position()
		print("New destination %s" % Saver.data.mastermind.destination)
	
	var final_delta = delta * Datetimer.time_factor * speed
	
	var alternate_left = Vector2(Saver.data.mastermind.destination.x - Saver.data.earth.width, Saver.data.mastermind.destination.y)
	var alternate_left_diff = alternate_left - Saver.data.mastermind.location
	
	var alternate_right = Vector2(Saver.data.mastermind.destination.x + Saver.data.earth.width, Saver.data.mastermind.destination.y)
	var alternate_right_diff = alternate_right - Saver.data.mastermind.location
	
	var diff = Saver.data.mastermind.destination - Saver.data.mastermind.location
	
	if alternate_left_diff.length() < diff.length():
		Saver.data.mastermind.location = Saver.data.mastermind.location.move_toward(alternate_left, final_delta)
	elif alternate_right_diff.length() < diff.length():
		Saver.data.mastermind.location = Saver.data.mastermind.location.move_toward(alternate_right, final_delta)
	else:
		Saver.data.mastermind.location = Saver.data.mastermind.location.move_toward(Saver.data.mastermind.destination, final_delta)
	
	if Saver.data.mastermind.location.x < -(Saver.data.earth.width / 2):
		Saver.data.mastermind.location.x = Saver.data.earth.width /  2
	elif Saver.data.mastermind.location.x > Saver.data.earth.width / 2:
		Saver.data.mastermind.location.x = -(Saver.data.earth.width /  2)

func _on_day_changed(date: DatetimeData):
	print("Master mind plans attacks")
	var attack_planned: AttackData = AttackData.new()
	attack_planned.datetime = DatetimeData.new(date.timestamp + rng.randi_range(3600, 86400))
	attack_planned.location = _get_random_earth_position()
	Saver.data.mastermind.attacks_planned.append(attack_planned)

func _get_random_earth_position():
	return Vector2(randi() % Saver.data.earth.width - Saver.data.earth.width/2, randi() % Saver.data.earth.height - Saver.data.earth.height/2)
