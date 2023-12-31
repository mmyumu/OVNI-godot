@tool
extends Node

func _ready():
	$BaseNameLabel.text = Global.get_current_base().name

func _on_base_layout_placing_over():
	$BaseMenu.reenable()

func _on_build_sub_menu_menu_object_pressed(menu_button, building_template: BuildingTemplate, parent_object):
	var building_to_place = Saver.data.building_templates.scenes[building_template.type].instantiate()
	building_to_place.template_type = building_template.type
	building_to_place.set_placing_mode()
	$BaseLayout.set_placing(building_to_place)
	$BaseMenu.disable()
