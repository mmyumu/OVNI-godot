extends Node2D


func _ready():
	display_root_menu()

func _input(event):
	if event.is_action_pressed("cancel"):
		display_root_menu()

func display_root_menu():
	$RootMenu.show()
	$BasesMenu.hide()
	
	$RootMenu/Bases.grab_focus()

func _on_save_pressed():
	print("should save")

func _on_bases_pressed():
	$RootMenu.hide()
	$BasesMenu.show()
	
	$BasesMenu/NewBase.grab_focus()

func _on_bases_back_pressed():
	display_root_menu()


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
