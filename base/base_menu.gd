extends Node2D

var last_focus_control

signal construction_selected(construction_scene)

func _ready():
	display_root_menu()

func _input(event):
	if event.is_action_pressed("cancel"):
		display_root_menu()
	
func disable():
	for node in find_children("*", "Button", true):
		node.disabled = true
		node.set_focus_mode(0)
	set_process_input(false)

func enable():
	for node in find_children("*", "Button", true):
		node.disabled = false
		node.set_focus_mode(2)
	last_focus_control.grab_focus()
	set_process_input(true)

func _on_construction_pressed():
	$RootMenu.hide()
	$ConstructionMenu.show()
	
	$ConstructionMenu/ResearchFacility.grab_focus()

func _on_construction_back_pressed():
	display_root_menu()

func display_root_menu():
	$RootMenu.show()
	$ConstructionMenu.hide()
	
	$RootMenu/Construction.grab_focus()

func _on_research_facility_pressed():
	last_focus_control = $ConstructionMenu/ResearchFacility
	construction_selected.emit(ConstructionsData.SCENES[ConstructionsData.Type.RESEARCH])

func _on_hospital_pressed():
	last_focus_control = $ConstructionMenu/Hospital
	construction_selected.emit(ConstructionsData.SCENES[ConstructionsData.Type.HOSPITAL])

func _on_back_pressed():
	get_tree().change_scene_to_file("res://global/main.tscn")
