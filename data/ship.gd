class_name ShipData extends Resource

const uuid_util = preload('res://addons/uuid/uuid.gd')

@export var id: String
@export var name: String = "Placeholder"
@export var hangared: bool = true
@export var location: Vector2 = Vector2.ZERO
@export var attack: AttackData
@export var rotation: float = 0.
@export var base: BaseData
@export var speed: float = 0.05
@export var destination: Resource

func _init():
	id = uuid_util.v4()

func compute_eta(destination: Vector2) -> DatetimeData:
	var current_location = location
	if hangared:
		current_location = base.location
		
	var distance = current_location.distance_to(destination)
	
	var alternate_left = Vector2(destination.x - Saver.data.earth.width, destination.y)
	var distance_left = (alternate_left - current_location).length()
	
	
	var alternate_right = Vector2(destination.x + Saver.data.earth.width, destination.y)
	var distance_right = (alternate_right - current_location).length()
	
	var eta
	if distance_left < distance:
		eta = DatetimeData.new(Saver.data.datetime.timestamp + (distance_left / speed))
	elif distance_right < distance:
		eta = DatetimeData.new(Saver.data.datetime.timestamp + (distance_right / speed))
	else:
		eta = DatetimeData.new(Saver.data.datetime.timestamp + (distance / speed))
	
	return eta

func move():
	hangared = false

func parks():
	print("Ship %s parks in base %s" % [name, base.name])
	hangared = true

func set_attack(attack_to_set: AttackData):
	attack = attack_to_set
	set_destination(attack_to_set)

func get_current_destination():
	if at_current_destination():
		return null
	
	return get_destination()

func set_destination(destination_to_set: Resource):
	destination = destination_to_set

func get_destination():
	if destination and "location" in destination:
		return destination
	return null

func at_destination(destination_to_check: Resource):
	if "location" in destination_to_check:
		return abs(location.x - destination_to_check.location.x) < 1 and abs(location.y - destination_to_check.location.y) < 1
	return false

func at_current_destination():
	var dest = get_destination()
	return get_destination() and at_destination(dest)
