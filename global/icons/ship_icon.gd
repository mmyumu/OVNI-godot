extends Node2D

var ship: Ship

func set_ship(ship_to_set: Ship):
	ship = ship_to_set
	$Label.text = ship.name
	position = ship.location

func _ready():
	$AnimatedSprite2D.play()

func _process(delta):
	if ship.hangared:
		visible = false
	else:
		visible = true
		position = ship.location
		$AnimatedSprite2D.rotation = ship.rotation
