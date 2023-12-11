class_name GameSlot extends HBoxContainer

var slot_number: int
var data: Data

func set_slot_number(slot_number_to_set):
	slot_number = slot_number_to_set

func _ready():
	build_game_slot()

func build_game_slot():
	data = Saver.get_data(slot_number)
	if data:
		$EmptySlot.visible = false
		$Slot.visible = true
		
		$Slot/MarginContainer/VBoxContainer/Name.text = Saver.get_data(slot_number).get_data_name()
		
		var datetime: DatetimeData = Saver.get_data(slot_number).datetime
		$Slot/MarginContainer/VBoxContainer/Date.text = datetime.get_datetime_str()
	else:
		$EmptySlot.visible = true
		$Slot.visible = false

func set_focus():
	if data:
		$Slot.grab_focus()
	else:
		$EmptySlot.grab_focus()

func _on_erase_pressed():
	Saver.erase_data(slot_number)
	data = null
	build_game_slot()

func _on_empty_slot_pressed():
	Saver.set_slot(slot_number)
	Saver.reset_data()
	Saver.save_data()
	build_game_slot()
	get_tree().change_scene_to_file("res://global/main.tscn")
	Datetimer.time_factor = 1.

func _on_slot_pressed():
	Saver.set_slot(slot_number)
	Saver.load_data()
	build_game_slot()
	get_tree().change_scene_to_file("res://global/main.tscn")
	Datetimer.time_factor = 1.
