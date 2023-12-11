extends Node

func _ready():
	Datetimer.day_changed.connect(_on_day_changed)

func _on_global_menu_new_base_selected():
	Global.last_time_factor = Datetimer.time_factor
	Datetimer.time_factor = 1.
	$GlobalMenu.disable()
	$EarthLayout.set_creating_new_base()

func _on_earth_layout_base_creation_over():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	await get_tree().create_timer(0.1).timeout
	$GlobalMenu.build_bases_menu()
	$GlobalMenu.enable()

func _on_global_menu_menu_base_focus_entered(base: BaseData):
	$EarthLayout.highlight_base(base)

func _on_global_menu_menu_base_focus_exited(base: BaseData):
	$EarthLayout.unhighlight_base()

func _on_day_changed(date: DatetimeData):
	Saver.save_data()
