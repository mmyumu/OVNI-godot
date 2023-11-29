class_name BaseIcon extends Node2D

var base: BaseData

func set_base(base_to_set: BaseData):
	base = base_to_set
	$Label.text = base.name
	position = base.location
	print("set base icon position %s" % position)
