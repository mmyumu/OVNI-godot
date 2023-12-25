class_name EventInfoPanel extends Node2D

var ship: ShipData
var event: AttackData

func _ready():
	$Panel/GridContainer/AttackValueLabel.text = event.name
	$Panel/GridContainer/ETAValueLabel.text = ship.compute_eta(event.location).get_datetime_str()

func set_data(ship_to_set: ShipData, event_to_set: AttackData):
	event = event_to_set
	ship = ship_to_set
