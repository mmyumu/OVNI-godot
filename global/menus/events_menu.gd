extends VBoxContainer

var menu_data_button_scene: PackedScene = preload("res://util/menu_data_button.tscn")

var first_button: Button

signal back_pressed()
signal menu_data_focus_entered(data: Resource)
signal menu_data_focus_exited(data: Resource)

func _ready():
	build()

func display():
	show()
	first_button.grab_focus()

func build():
	var previous_menu_button: Button
	first_button = $Back
	
	var i = 0
	for attack in Saver.data.mastermind.attacks_ongoing:
		var menu_data_button = find_child(attack.name, true, false)
		if not menu_data_button:
			menu_data_button = menu_data_button_scene.instantiate()
			menu_data_button.name = attack.name
			menu_data_button.text = attack.name
			menu_data_button.set_data(attack)
			menu_data_button.menu_data_pressed.connect(_on_menu_data_pressed)
			menu_data_button.menu_data_focus_entered.connect(_on_menu_data_focus_entered)
			menu_data_button.menu_data_focus_exited.connect(_on_menu_data_focus_exited)
			
			add_child(menu_data_button)
			move_child(menu_data_button, i)

		if previous_menu_button:
			previous_menu_button.focus_neighbor_bottom = previous_menu_button.get_path_to(menu_data_button)
			menu_data_button.focus_neighbor_top = menu_data_button.get_path_to(previous_menu_button)

		if i == 0:
			first_button = menu_data_button
		previous_menu_button = menu_data_button
		i += 1

	if previous_menu_button:
		previous_menu_button.focus_neighbor_bottom = $Back.get_path()
		$Back.focus_neighbor_top = $Back.get_path_to(previous_menu_button)

func _on_menu_data_pressed(menu_button: MenuBaseButton, base: BaseData):
	Global.current_base = base
	Global.last_menu_button_path = menu_button.get_path()
	Global.last_time_factor = Datetimer.time_factor
	Datetimer.time_factor = 1.
	get_tree().change_scene_to_file("res://shootempup/main.tscn")

func _on_menu_data_focus_entered(menu_button: MenuDataButton, data: Resource):
	menu_data_focus_entered.emit(data)

func _on_menu_data_focus_exited(menu_button: MenuDataButton, data: Resource):
	menu_data_focus_exited.emit(data)

func _on_back_pressed():
	back_pressed.emit()
