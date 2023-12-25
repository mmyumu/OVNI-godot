class_name ShipData extends Resource

@export var name: String = "Placeholder"
@export var hangared: bool = true
@export var location: Vector2 = Vector2.ZERO
@export var rotation: float = 0.
@export var base_id: String
@export var speed: float = 0.05

func compute_eta(destination: Vector2) -> DatetimeData:
	var current_location = location
	if hangared:
		current_location = get_base().location
		
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

func get_base() -> BaseData:
	return Saver.data.bases[base_id]
