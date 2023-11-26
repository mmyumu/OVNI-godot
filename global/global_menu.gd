extends Node2D

var right_menu_button_scene: PackedScene = preload("res://util/right_menu_button.tscn")
var last_focus_control

signal new_base_selected()

func _ready():
	display_root_menu()
	build_bases_menu()

func _input(event):
	if event.is_action_pressed("cancel"):
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
	var previous_button: Button = get_node("./BasesMenu/NewBase")
#	$BasesMenu/NewBase
	
	var i = 0
	for base in Saver.data.bases:
		var button = right_menu_button_scene.instantiate()
		button.name = base.name
		button.text = base.name
		$BasesMenu.add_child(button)
		$BasesMenu.move_child(button, i + 1) # +1 because there is 1 button (new bases) before

		previous_button.focus_neighbor_bottom = previous_button.get_path_to(button)
		button.focus_neighbor_top = button.get_path_to(previous_button)

		previous_button = button
		i += 1

	previous_button.focus_neighbor_bottom = $BasesMenu/Back.get_path()
	$BasesMenu/Back.focus_neighbor_top = $BasesMenu/Back.get_path_to(previous_button)

func _on_save_pressed():
	print("should save?")

func _on_bases_pressed():
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
