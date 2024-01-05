@tool
extends Node

func _ready():
	$BaseNameLabel.text = Global.get_current_base().name

func _on_base_menu_construction_selected(construction_scene):
	var construction = construction_scene.instantiate()
	construction.set_placing_mode()
	$BaseLayout.set_placing(construction)
	$BaseMenu.disable()


func _on_base_layout_placing_over():
	$BaseMenu.enable()

func _on_build_sub_menu_menu_object_pressed(menu_button, construction_template: ConstructionTemplateData, parent_object):
	var construction = Saver.data.construction_templates.scenes[construction_template.type].instantiate()
	construction.template_type = construction_template.type
	construction.set_placing_mode()
	$BaseLayout.set_placing(construction)
	$BaseMenu.disable()
