extends Node


signal ship_reached_attack(ship:Ship, attack: Attack)
signal ship_hangared(ship: Ship)

func _process(delta):
	check_destination()
	move(delta)

func check_destination():
	for base in Saver.data.get_bases():
		for ship in base.get_ships():
			if ship.attack and ship.attack.status == Attack.Status.OVER:
				ship.attack = null
				ship.set_destination(base)

func move(delta):
	for ship in Saver.data.get_ships():
		move_ship(ship, delta)

func move_ship(ship: Ship, delta):
	if not ship.get_current_destination():
		return

	var final_delta = delta * Datetimer.time_factor * ship.speed
	ship.location = ship.location.move_toward(ship.get_current_destination().location, final_delta)

	if ship.at_current_destination():
		print("Ship: reached destination %s at %s" % [ship.destination, Saver.data.datetime.get_datetime_str()])
		
		if ship.destination is Attack:
			ship_reached_attack.emit(ship, ship.attack)
		elif ship.destination is Base:
			var previous_hangared = ship.hangared
			ship.parks()
			if previous_hangared != ship.hangared:
				ship_hangared.emit(ship)
	else:
		var v = ship.location - ship.get_current_destination().location
		var angle = v.angle() - PI/2

		# We do not need to use final_delta here because the rotation does not matter on the game, it is just visual
		# Since the rotation goes crazy using final_delta when timer is accelerated (it rotates too much),
		# then we use either final_delta or delta
		ship.rotation = lerp_angle(ship.rotation, angle, min(final_delta, delta))

func move_and_attack(ship: Ship, attack: Attack):
	var previous_hangared = ship.hangared
	ship.set_attack(attack)
	ship.move()
	if previous_hangared != ship.hangared:
		ship_hangared.emit(ship)
