extends VBoxContainer

var menu_base_button_scene: PackedScene = preload("res://util/menu_base_button.tscn")

signal new_base_pressed(new_base_button: Button)
signal back_pressed()
signal menu_base_focus_entered(base: BaseData)
signal menu_base_focus_exited(base: BaseData)

func _ready():
	build()

func display():
	show()
	$NewBase.grab_focus()

func build():
	var previous_menu_button: Button = $NewBase
	
	var i = 0
	for base in Saver.data.bases:
		var menu_base_button = find_child(base.name, true, false)
		if not menu_base_button:
			menu_base_button = menu_base_button_scene.instantiate()
			menu_base_button.name = base.name
			menu_base_button.text = base.name
			menu_base_button.set_base(base)
			menu_base_button.menu_base_pressed.connect(_on_menu_base_pressed)
			menu_base_button.menu_base_focus_entered.connect(_on_menu_base_focus_entered)
			menu_base_button.menu_base_focus_exited.connect(_on_menu_base_focus_exited)
			
			add_child(menu_base_button)
			move_child(menu_base_button, i + 1) # +1 because there is 1 button (new bases) before

		previous_menu_button.focus_neighbor_bottom = previous_menu_button.get_path_to(menu_base_button)
		menu_base_button.focus_neighbor_top = menu_base_button.get_path_to(previous_menu_button)

		previous_menu_button = menu_base_button
		i += 1

	previous_menu_button.focus_neighbor_bottom = $Back.get_path()
	$Back.focus_neighbor_top = $Back.get_path_to(previous_menu_button)

func _on_menu_base_pressed(menu_button: MenuBaseButton, base: BaseData):
	Global.current_base = base
	Global.last_menu_button_path = menu_button.get_path()
	Global.last_time_factor = Datetimer.time_factor
	Datetimer.time_factor = 1.
	get_tree().change_scene_to_file("res://base/main.tscn")

func _on_menu_base_focus_entered(menu_button: MenuBaseButton, base: BaseData):
	menu_base_focus_entered.emit(base)

func _on_menu_base_focus_exited(menu_button: MenuBaseButton, base: BaseData):
	menu_base_focus_exited.emit(base)

func _on_new_base_pressed():
	new_base_pressed.emit($NewBase)

func _on_back_pressed():
	back_pressed.emit()
