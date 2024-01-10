class_name BaseInfoPanel extends InfoPanel

var base: Base


func custom_connect():
	Headquarters.bases_changed.connect(on_bases_changed)

func build():
	if base.construction_status == Construction.Status.IN_PROGRESS:
		$PanelContainer/GridContainer/ConstructionStartLabel.visible = true
		$PanelContainer/GridContainer/ConstructionStartValueLabel.visible = true
		$PanelContainer/GridContainer/ConstructionEndLabel.text = "Construction ETA:"
		
		$PanelContainer/GridContainer/ConstructionStartValueLabel.text = base.construction_date.get_datetime_str()
		
		var constructionETA = Datetime.new(base.construction_date.timestamp + Saver.data.base_construction_duration)
		$PanelContainer/GridContainer/ConstructionEndValueLabel.text = constructionETA.get_datetime_str()
	elif base.construction_status == Construction.Status.DONE:
		$PanelContainer/GridContainer/ConstructionEndLabel.text = "Construction:"
		$PanelContainer/GridContainer/ConstructionEndValueLabel.text = base.construction_end.get_datetime_str()
		$PanelContainer/GridContainer/ConstructionStartLabel.visible = false
		$PanelContainer/GridContainer/ConstructionStartValueLabel.visible = false

	$PanelContainer/GridContainer/NameValueLabel.text = base.name
	swap_left_right(base)

func set_data(_base: Base):
	base = _base

func on_bases_changed(changed_bases: Array[Base]):
	if base in changed_bases:
		build()
