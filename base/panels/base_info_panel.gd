class_name BaseInfoPanel extends InfoPanel


func build():
	build_base()
	position.x = 530
	position.y = -200
	$PanelContainer.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT, Control.PRESET_MODE_MINSIZE, false)
	
	

func build_base():
	# Abstract
	pass
