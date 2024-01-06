class_name EventInfoPanel extends Node2D

var ship: Ship
var event: Attack

func _ready():
	$PanelContainer/GridContainer/AttackValueLabel.text = event.name
	$PanelContainer/GridContainer/ETAValueLabel.text = ship.compute_eta(event.location).get_datetime_str()

func set_data(ship_to_set: Ship, event_to_set: Attack):
	event = event_to_set
	ship = ship_to_set
