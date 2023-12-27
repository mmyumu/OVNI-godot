extends Node


func _process(delta):
	move(delta)

func move(delta):
	for base_id in Saver.data.bases:
		var base: BaseData = Saver.data.bases[base_id]
		for ship in base.ships:
			move_ship(ship, delta)

func move_ship(ship: ShipData, delta):
	if not ship.get_destination():
		return
		
	if abs(ship.location.x - ship.get_destination().x) < 1 and abs(ship.location.y - ship.get_destination().y) < 1:
		print("Ship: reached destination %s at %s" % [ship.get_destination(), Saver.data.datetime.get_datetime_str()])
		ship.stands_by()
	else:
		var final_delta = delta * Datetimer.time_factor * ship.speed
		ship.location = ship.location.move_toward(ship.get_destination(), final_delta)

		var v = ship.location - ship.get_destination()
		var angle = v.angle() - PI/2

		# We do not need to use final_delta here because the rotation does not matter on the game, it is just visual
		# Since the rotation goes crazy using final_delta when timer is accelerated (it rotates too much),
		# then we use either final_delta or delta
		ship.rotation = lerp_angle(ship.rotation, angle, min(final_delta, delta))
