class_name SubMenu extends VBoxContainer

@export var menu_offset: int = 0

var menu_object_button_scene: PackedScene = preload("res://util/menu_object_button.tscn")

var parent_object: Object
var first_button: Button

signal back_pressed()
signal menu_object_pressed(menu_button: MenuObjectButton, object: Object, parent_object: Object)
signal menu_object_focus_entered(menu_button: MenuObjectButton, object: Object, parent_object: Object)
signal menu_object_focus_exited(menu_button: MenuObjectButton, object: Object, parent_object: Object)

func _ready():
	build()

func display(parent_object_to_set: Object = null):
	parent_object = parent_object_to_set
	show()
	grab_default_focus()

func get_menu_data() -> Array[MenuDatum]:
	return []

func grab_default_focus():
	first_button.grab_focus()

func build():
	var previous_menu_button: Button
	first_button = $Back
	
	var i = 0
	for datum in self.get_menu_data():
		var menu_object_button = find_child(datum.button_name, true, false)
		if not menu_object_button:
			menu_object_button = menu_object_button_scene.instantiate()
			menu_object_button.name = datum.button_name
			menu_object_button.text = datum.button_text
			menu_object_button.set_object(datum.object)
			menu_object_button.menu_object_pressed.connect(_on_menu_object_pressed)
			menu_object_button.menu_object_focus_entered.connect(_on_menu_object_focus_entered)
			menu_object_button.menu_object_focus_exited.connect(_on_menu_object_focus_exited)
		
			add_child(menu_object_button)
			move_child(menu_object_button, i + menu_offset)

		if previous_menu_button:
			previous_menu_button.focus_neighbor_bottom = previous_menu_button.get_path_to(menu_object_button)
			menu_object_button.focus_neighbor_top = menu_object_button.get_path_to(previous_menu_button)

		if i == 0:
			first_button = menu_object_button
		previous_menu_button = menu_object_button
		i += 1

	if previous_menu_button:
		previous_menu_button.focus_neighbor_bottom = $Back.get_path()
		$Back.focus_neighbor_top = $Back.get_path_to(previous_menu_button)

func _on_back_pressed():
	back_pressed.emit()

func _on_menu_object_pressed(menu_button: MenuObjectButton, object: Object):
	menu_object_pressed.emit(menu_button, object, parent_object)

func _on_menu_object_focus_entered(menu_button: MenuObjectButton, object: Object):
	menu_object_focus_entered.emit(menu_button, object, parent_object)

func _on_menu_object_focus_exited(menu_button: MenuObjectButton, object: Object):
	menu_object_focus_exited.emit(menu_button, object, parent_object)
