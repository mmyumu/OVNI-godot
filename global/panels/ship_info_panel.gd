class_name ShipInfoPanel extends InfoPanel

var ship: Ship

func _ready():
	$PanelContainer/GridContainer/NameValueLabel.text = ship.name
	$PanelContainer/GridContainer/BaseValueLabel.text = ship.base.name
	
	if ship.destination and "name" in ship.destination:
		$PanelContainer/GridContainer/DestinationValueLabel.text = ship.destination.name
		$PanelContainer/GridContainer/DestinationLabel.visible = true
		$PanelContainer/GridContainer/DestinationValueLabel.visible = true
	else:
		$PanelContainer/GridContainer/DestinationLabel.visible = false
		$PanelContainer/GridContainer/DestinationValueLabel.visible = false
	
	swap_left_right(ship)


func set_data(_ship: Ship):
	ship = _ship
