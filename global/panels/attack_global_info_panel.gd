class_name AttackGlobalInfoPanel extends GlobalInfoPanel

var attack: Attack
var ship: Ship

func build():
	$PanelContainer/GridContainer/AttackValueLabel.text = attack.name
	$PanelContainer/GridContainer/DateValueLabel.text = attack.datetime.get_datetime_str()
	
	if ship:
		$PanelContainer/GridContainer/ETALabel.visible = true
		$PanelContainer/GridContainer/ETAValueLabel.visible = true
		$PanelContainer/GridContainer/ETAValueLabel.text = ship.compute_eta(attack.location).get_datetime_str()
	else:
		$PanelContainer/GridContainer/ETALabel.visible = false
		$PanelContainer/GridContainer/ETAValueLabel.visible = false
	
	swap_left_right(attack)

func set_data(_attack: Attack, _ship: Ship):
	attack = _attack
	ship = _ship
	
