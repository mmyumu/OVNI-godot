class_name InfoPanel extends Node2D

func _ready():
	custom_connect()
	build()

func custom_connect():
	# Abstract
	pass

func build():
	# Abstract
	pass

func swap_left_right(object):
	if "location" in object:
		if object.location.x > 0:
			position.x = object.location.x - 35
			position.y = object.location.y - 20
			$PanelContainer.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT, Control.PRESET_MODE_MINSIZE, false)
		else:
			position.x = object.location.x + 25
			position.y = object.location.y - 20
			$PanelContainer.set_anchors_and_offsets_preset(Control.PRESET_TOP_LEFT, Control.PRESET_MODE_MINSIZE, false)	
