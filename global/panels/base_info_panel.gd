class_name BaseInfoPanel extends InfoPanel

var base: Base

func _ready():
	if base.construction_status == Construction.Status.IN_PROGRESS:
		$PanelContainer/GridContainer/ConstructionStartLabel.visible = true
		$PanelContainer/GridContainer/ConstructionStartValueLabel.visible = true
		$PanelContainer/GridContainer/ConstructionETALabel.visible = true
		$PanelContainer/GridContainer/ConstructionETAValueLabel.visible = true
		
		$PanelContainer/GridContainer/ConstructionStartValueLabel.text = base.construction_date.get_datetime_str()
		
		var constructionETA = Datetime.new(base.construction_date.timestamp + Saver.data.base_construction_duration)
		$PanelContainer/GridContainer/ConstructionETAValueLabel.text = constructionETA.get_datetime_str()
	elif base.construction_status == Construction.Status.DONE:
		$PanelContainer/GridContainer/ConstructionStartLabel.visible = false
		$PanelContainer/GridContainer/ConstructionStartValueLabel.visible = false
		$PanelContainer/GridContainer/ConstructionETALabel.visible = false
		$PanelContainer/GridContainer/ConstructionETAValueLabel.visible = false

	if base.location.x > 0:
		position.x = base.location.x - 35
		position.y = base.location.y - 20
		$PanelContainer.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT, Control.PRESET_MODE_MINSIZE, false)
	else:
		position.x = base.location.x + 25
		position.y = base.location.y - 20
		$PanelContainer.set_anchors_and_offsets_preset(Control.PRESET_TOP_LEFT, Control.PRESET_MODE_MINSIZE, false)
		
	$PanelContainer/GridContainer/NameValueLabel.text = base.name

func set_data(_base: Base):
	base = _base
