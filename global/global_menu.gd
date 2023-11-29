extends Node2D

var menu_base_button_scene: PackedScene = preload("res://util/menu_base_button.tscn")
var last_focus_control

signal new_base_selected()

func _ready():
	display_root_menu()
	build_bases_menu()
	
	if not Global.last_menu_button_path.is_empty():
		display_bases_menu()
		get_node(Global.last_menu_button_path).grab_focus()
		Global.last_menu_button_path = ""

func _input(event):
	if event.is_action_pressed("cancel") and not $RootMenu.visible:
		display_root_menu()

func disable():
	for node in find_children("*", "Button", true, false):
		print(node.name)
		node.disabled = true
		node.set_focus_mode(0)
	set_process_input(false)

func enable():
	for node in find_children("*", "Button", true, false):
		node.disabled = false
		node.set_focus_mode(2)
	last_focus_control.grab_focus()
	set_process_input(true)

func display_root_menu():
	$RootMenu.show()
	$BasesMenu.hide()
	
	$RootMenu/Bases.grab_focus()

func build_bases_menu():
	var previous_menu_button: Button = $BasesMenu/NewBase
	
	var i = 0
	for base in Saver.data.bases:
		var menu_base_button = $BasesMenu.find_child(base.name, true, false)
		if not menu_base_button:
			menu_base_button = menu_base_button_scene.instantiate()
			menu_base_button.name = base.name
			menu_base_button.text = base.name
			menu_base_button.set_base(base)
			menu_base_button.menu_base_pressed.connect(_on_menu_base_pressed)
			
			$BasesMenu.add_child(menu_base_button)
			$BasesMenu.move_child(menu_base_button, i + 1) # +1 because there is 1 button (new bases) before

		previous_menu_button.focus_neighbor_bottom = previous_menu_button.get_path_to(menu_base_button)
		menu_base_button.focus_neighbor_top = menu_base_button.get_path_to(previous_menu_button)

		previous_menu_button = menu_base_button
		i += 1

	previous_menu_button.focus_neighbor_bottom = $BasesMenu/Back.get_path()
	$BasesMenu/Back.focus_neighbor_top = $BasesMenu/Back.get_path_to(previous_menu_button)

func _on_save_pressed():
	print("should save?")

func _on_bases_pressed():
	display_bases_menu()

func display_bases_menu():
	$RootMenu.hide()
	$BasesMenu.show()
	
	$BasesMenu/NewBase.grab_focus()

func _on_bases_back_pressed():
	display_root_menu()

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_new_base_pressed():
	last_focus_control = $BasesMenu/NewBase
	new_base_selected.emit()

func _on_menu_base_pressed(menu_button: MenuBaseButton, base: BaseData):
	Global.current_base = base
	Global.last_menu_button_path = menu_button.get_path()
	get_tree().change_scene_to_file("res://base/main.tscn")
