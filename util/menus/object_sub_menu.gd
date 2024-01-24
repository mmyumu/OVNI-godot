class_name ObjectSubMenu extends SubMenu

@export var menu_offset: int = 0

var menu_object_button_scene: PackedScene = preload("res://util/menus/menu_object_button.tscn")

var parent_object: Object

signal back_pressed(parent_object: Object)
signal menu_object_pressed(menu_button: MenuObjectButton, object: Object, parent_object: Object)
signal menu_object_focus_entered(menu_button: MenuObjectButton, object: Object, parent_object: Object)
signal menu_object_focus_exited(menu_button: MenuObjectButton, object: Object, parent_object: Object)

func _ready():
	custom_connect()

func custom_connect():
	pass

func get_menu_data(parent_object: Object) -> Array[MenuDatum]:
	return []

func build(parent_object_to_set: Object = null):
	if parent_object_to_set:
		parent_object = parent_object_to_set

	var previous_menu_button: Button
	first_button = $Back
	
	var i = 0
	var menu_data = get_menu_data(parent_object)
	for datum in menu_data:
		var create_child = false
		var menu_object_button = find_child(datum.button_name, true, false)
		if not menu_object_button:
			menu_object_button = menu_object_button_scene.instantiate()
			menu_object_button.name = datum.button_name
			menu_object_button.text = datum.button_text
			menu_object_button.set_object(datum.object)
			menu_object_button.menu_object_pressed.connect(_on_menu_object_pressed)
			menu_object_button.menu_object_focus_entered.connect(_on_menu_object_focus_entered)
			menu_object_button.menu_object_focus_exited.connect(_on_menu_object_focus_exited)
			
			create_child = true

		if datum.font_color:
			menu_object_button.set("theme_override_colors/font_color", datum.font_color)
			menu_object_button.set("theme_override_colors/font_focus_color", datum.font_color)

		if create_child:
			add_child(menu_object_button)
			move_child(menu_object_button, i + menu_offset)
			
		menu_object_button.disabled = datum.disabled

		if previous_menu_button:
			previous_menu_button.focus_neighbor_bottom = previous_menu_button.get_path_to(menu_object_button)
			menu_object_button.focus_neighbor_top = menu_object_button.get_path_to(previous_menu_button)

		if i == 0:
			first_button = menu_object_button
		previous_menu_button = menu_object_button
		i += 1

	# Clear items that were deleted
	for node in find_children("*", "MenuObjectButton", true, false):
		var found = false
		for datum in menu_data:
			if node.object == datum.object:
				found = true
				break
		if not found:
			if last_focus == node:
				last_focus = null
			node.queue_free()

	if previous_menu_button:
		previous_menu_button.focus_neighbor_bottom = $Back.get_path()
		$Back.focus_neighbor_top = $Back.get_path_to(previous_menu_button)

	if visible == true:
		if is_instance_valid(last_focus) and last_focus.disabled == false:
			last_focus.grab_focus()
		else:
			grab_default_focus()

func _on_back_pressed():
	back_pressed.emit(parent_object)

func _on_menu_object_pressed(menu_button: MenuObjectButton, object: Object):
	menu_object_pressed.emit(menu_button, object, parent_object)

func _on_menu_object_focus_entered(menu_button: MenuObjectButton, object: Object):
	last_focus = menu_button
	menu_object_focus_entered.emit(menu_button, object, parent_object)

func _on_menu_object_focus_exited(menu_button: MenuObjectButton, object: Object):
	menu_object_focus_exited.emit(menu_button, object, parent_object)
