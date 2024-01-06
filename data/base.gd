class_name Base extends Resource

const uuid_util = preload('res://addons/uuid/uuid.gd')

@export var id: String
@export var name: String
@export var location: Vector2
@export var base_layout: BaseLayout = BaseLayout.new()
@export var ships: Array[String] = []

func _init():
	id = uuid_util.v4()

func get_ships():
	var ships_to_get: Array[Ship] = []
	for ship_id in Saver.data.ships:
		if ship_id in ships:
			ships_to_get.append(Saver.data.ships[ship_id])
	return ships_to_get

func add_ship(ship: Ship):
	ships.append(ship.id)
