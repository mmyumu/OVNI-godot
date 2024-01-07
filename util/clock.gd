@tool
extends Node2D

@export var controls: bool = true

func _ready():
	$VBoxContainer/ButtonsContainer.visible = controls

func _process(delta):
	if not Engine.is_editor_hint():
		var datetime: Datetime = Saver.data.datetime
		$VBoxContainer/TimerContainer/DateLabel.text = datetime.get_date_str()
		$VBoxContainer/TimerContainer/TimeLabel.text = datetime.get_time_str()

func _on_x1_button_pressed():
	Datetimer.time_factor = 1.

func _on_x100_button_pressed():
	Datetimer.time_factor = 100.

func _on_x10000_button_pressed():
	Datetimer.time_factor = 10000.
