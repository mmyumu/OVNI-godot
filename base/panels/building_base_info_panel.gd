class_name BuildingBaseInfoPanel extends BaseInfoPanel

var building: Building

func build_base():
	$PanelContainer/GridContainer/NameValueLabel.text = building.get_template().name
