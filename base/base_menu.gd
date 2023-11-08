extends Node2D

var research_facility_scene: PackedScene = preload("res://base/constructions/research_facility.tscn")

var last_focus_control

signal construction_selected(construction_scene)

func _ready():
	display_root_menu()

func _on_construction_pressed():
	$RootMenu.hide()
	$ConstructionMenu.show()
	
	$ConstructionMenu/ResearchFacility.grab_focus()
#	last_focus_control = $ConstructionMenu/ResearchFacility

func _on_back_pressed():
	display_root_menu()

func display_root_menu():
	$RootMenu.show()
	$ConstructionMenu.hide()
	
	$RootMenu/Construction.grab_focus()
	last_focus_control = $RootMenu/Construction


func _on_research_facility_pressed():
	last_focus_control.release_focus()
	construction_selected.emit(research_facility_scene)
