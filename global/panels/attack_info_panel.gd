class_name AttackInfoPanel extends InfoPanel

var ship: Ship
var attack: Attack

func _ready():
	$PanelContainer/GridContainer/AttackValueLabel.text = attack.name
	$PanelContainer/GridContainer/ETAValueLabel.text = ship.compute_eta(attack.location).get_datetime_str()
	
	if attack.location.x > 0:
		position.x = attack.location.x - 35
		position.y = attack.location.y - 20
		$PanelContainer.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT, Control.PRESET_MODE_MINSIZE, false)
	else:
		position.x = attack.location.x + 25
		position.y = attack.location.y - 20
		$PanelContainer.set_anchors_and_offsets_preset(Control.PRESET_TOP_LEFT, Control.PRESET_MODE_MINSIZE, false)

func set_data(_ship: Ship, _attack: Attack):
	attack = _attack
	ship = _ship
