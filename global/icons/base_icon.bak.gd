class_name BaseIcon extends Sprite2D

var base: Base

func set_base(base_to_set: Base):
	base = base_to_set
	position = base.location
	print("set base icon position %s" % position)
