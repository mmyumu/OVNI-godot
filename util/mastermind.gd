extends Node

@export var speed: float = 0.02
@export var max_spawn_radius: float = 50.0

var rng = RandomNumberGenerator.new()

signal attack_spawned(attack_spawned: AttackData)

func _ready():
	Datetimer.day_changed.connect(_on_day_changed)

func _process(delta):
	start_attacks()
	move(delta)

func start_attacks():
	var to_be_deleted = []
	for attack_planned in Saver.data.mastermind.attacks_planned:
		if Saver.data.datetime.timestamp > attack_planned.datetime.timestamp:
			to_be_deleted.append(attack_planned)
			attack_planned.location = _get_random_earth_position_around_mothership()
			print("Attack planned at %s now spawns at %s" % [attack_planned.datetime.get_datetime_str(), attack_planned.location])
	
	for attack in to_be_deleted:
		Saver.data.mastermind.attacks_planned.erase(attack)
		Saver.data.mastermind.attacks_ongoing.append(attack)
		attack_spawned.emit(attack)

func move(delta):
	if not Saver.data.mastermind.destination:
		Saver.data.mastermind.destination = _get_random_earth_position()
		print("Init destination %s" % Saver.data.mastermind.destination)
		
	if abs(Saver.data.mastermind.location.x - Saver.data.mastermind.destination.x) < 1 and \
	 abs(Saver.data.mastermind.location.y - Saver.data.mastermind.destination.y) < 1:
		print("Reached destination %s at %s" % [Saver.data.mastermind.destination, Saver.data.datetime.get_datetime_str()])
		Saver.data.mastermind.destination = _get_random_earth_position()
		
		var distance = Saver.data.mastermind.location.distance_to(Saver.data.mastermind.destination)
		
		var eta = DatetimeData.new(Saver.data.datetime.timestamp + (distance / speed))
		print("New destination %s: ETA=%s" % [Saver.data.mastermind.destination, eta.get_datetime_str()])
	
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
	var attack_planned: AttackData = AttackData.new()
	attack_planned.name = "Attack %s" % Saver.data.mastermind.get_attack_number()
	attack_planned.datetime = DatetimeData.new(date.timestamp + rng.randi_range(3600, 86400))
	Saver.data.mastermind.attacks_planned.append(attack_planned)
	print("Attack planned at %s" % attack_planned.datetime.get_datetime_str())

func _get_random_earth_position():
	return Vector2(randi() % Saver.data.earth.width - Saver.data.earth.width/2, randi() % Saver.data.earth.height - Saver.data.earth.height/2)

func _get_random_earth_position_around_mothership():
	var angle_rad: float = randf() * 2 * PI
	var direction: Vector2 = Vector2(cos(angle_rad), sin(angle_rad))
	var spawn_radius = randf() * max_spawn_radius
	return Saver.data.mastermind.location + direction * spawn_radius
