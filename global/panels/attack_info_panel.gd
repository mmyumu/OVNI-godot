class_name AttackInfoPanel extends InfoPanel

var attack: Attack
var ship: Ship

func _ready():
	$PanelContainer/GridContainer/AttackValueLabel.text = attack.name
	$PanelContainer/GridContainer/DateValueLabel.text = attack.datetime.get_datetime_str()
	
	if ship:
		$PanelContainer/GridContainer/ETALabel.visible = true
		$PanelContainer/GridContainer/ETAValueLabel.visible = true
		$PanelContainer/GridContainer/ETAValueLabel.text = ship.compute_eta(attack.location).get_datetime_str()
	else:
		$PanelContainer/GridContainer/ETALabel.visible = false
		$PanelContainer/GridContainer/ETAValueLabel.visible = false
	
	if attack.location.x > 0:
		position.x = attack.location.x - 35
		position.y = attack.location.y - 20
		$PanelContainer.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT, Control.PRESET_MODE_MINSIZE, false)
	else:
		position.x = attack.location.x + 25
		position.y = attack.location.y - 20
		$PanelContainer.set_anchors_and_offsets_preset(Control.PRESET_TOP_LEFT, Control.PRESET_MODE_MINSIZE, false)

func set_data(_attack: Attack, _ship: Ship):
	attack = _attack
	ship = _ship
	
