@tool
extends Node

func _ready():
	$BaseNameLabel.text = Global.get_current_base().name

func _on_base_layout_placing_over():
	$BaseMenu.enable()

func _on_build_sub_menu_menu_object_pressed(menu_button, building_template: BuildingTemplateData, parent_object):
	var building = Saver.data.building_templates.scenes[building_template.type].instantiate()
	building.template_type = building_template.type
	building.set_placing_mode()
	$BaseLayout.set_placing(building)
	$BaseMenu.disable()
