class_name BaseIcon extends Node2D

var base: Base

func set_base(base_to_set: Base):
	base = base_to_set
	$Label.text = base.name
	position = base.location
	print("set base icon position %s" % position)
