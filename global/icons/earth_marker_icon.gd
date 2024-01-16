class_name EarthMarkerIcon extends Node2D

var ship: Ship

func _init():
	visible = false

func _ready():
	update_icon()

func update_icon():
	if ship.destination and ship.destination is EarthMarker:
		$AnimatedSprite2D.play()
		visible = true
		position = ship.destination.location
	else:
		visible = false
