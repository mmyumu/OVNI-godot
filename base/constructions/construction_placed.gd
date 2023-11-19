class_name ConstructionPlaced extends Node2D

@export var outline_color: Color = Color("331d0c"):
	set(value):
		outline_color = value
		queue_redraw()

@export var outline_width: float = 2.0:
	set(value):
		outline_width = value
		queue_redraw()


var color: Color
var construction: Construction


func _ready():
	position = construction.position
	
	$Area2D/DrawableCollisionPolygon2D.set_polygon(construction.get_collision_polygon().get_polygon())
	$Area2D/DrawableCollisionPolygon2D.position = construction.get_collision_polygon().position
	$Area2D/DrawableCollisionPolygon2D.color = construction.color
	$Area2D/DrawableCollisionPolygon2D.color.a = 1
	$Area2D/DrawableCollisionPolygon2D.outline_color = outline_color
	$Area2D/DrawableCollisionPolygon2D.outline_width = outline_width
