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
var building_to_place: BuildingToPlace


func _ready():
	Headquarters.buildings_changed.connect(_on_buildings_changed)
	$BuildingConstructionSprite2D.visible = building.construction_status == Construction.Status.IN_PROGRESS
	
	position = building_to_place.position
	rotation = building_to_place.rotation
	
	$Area2D/DrawableCollisionPolygon2D.set_polygon(building_to_place.get_collision_polygon().get_polygon())
	$Area2D/DrawableCollisionPolygon2D.position = building_to_place.get_collision_polygon().position
	$Area2D/DrawableCollisionPolygon2D.color = building_to_place.color
	$Area2D/DrawableCollisionPolygon2D.color.a = 1
	$Area2D/DrawableCollisionPolygon2D.outline_color = outline_color
	$Area2D/DrawableCollisionPolygon2D.outline_width = outline_width

func _on_buildings_changed(changed_buildings: Array[Building]):
	$BuildingConstructionSprite2D.visible = building.construction_status == Construction.Status.IN_PROGRESS
