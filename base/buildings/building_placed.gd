class_name BulidingPlaced extends Node2D

@export var outline_color: Color = Color("331d0c"):
	set(value):
		outline_color = value
		queue_redraw()

@export var outline_width: float = 2.0:
	set(value):
		outline_width = value
		queue_redraw()


var color: Color
var building: Building


func _ready():
	position = building.position
	rotation = building.rotation
	
	$Area2D/DrawableCollisionPolygon2D.set_polygon(building.get_collision_polygon().get_polygon())
	$Area2D/DrawableCollisionPolygon2D.position = building.get_collision_polygon().position
	$Area2D/DrawableCollisionPolygon2D.color = building.color
	$Area2D/DrawableCollisionPolygon2D.color.a = 1
	$Area2D/DrawableCollisionPolygon2D.outline_color = outline_color
	$Area2D/DrawableCollisionPolygon2D.outline_width = outline_width
