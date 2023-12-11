extends Node

@export var speed: float = 0.01

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
	
#	var position_difference = Saver.data.mastermind.destination - Saver.data.mastermind.location
#	var smoothed_velocity = position_difference * speed * delta
	
#	Vector2.to
#
#	Saver.data.mastermind.location += smoothed_velocity
	var final_delta = delta * Datetimer.time_factor * speed
	Saver.data.mastermind.location = Saver.data.mastermind.location.move_toward(Saver.data.mastermind.destination, final_delta)

func _on_day_changed(date: DatetimeData):
	print("Master mind plans attacks")
	var attack_planned: AttackData = AttackData.new()
	attack_planned.datetime = DatetimeData.new(date.timestamp + rng.randi_range(3600, 86400))
	attack_planned.location = _get_random_earth_position()
	Saver.data.mastermind.attacks_planned.append(attack_planned)

func _get_random_earth_position():
	return Vector2(randi() % Saver.data.earth.width - Saver.data.earth.width/2, randi() % Saver.data.earth.height - Saver.data.earth.height/2)
