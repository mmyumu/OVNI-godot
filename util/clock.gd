@tool
extends Node2D

@export var controls: bool = true


func _ready():
	$VBoxContainer/ButtonsContainer.visible = controls

	if Datetimer.time_factor == 1:
		set_color($VBoxContainer/ButtonsContainer/x1Button)
	elif Datetimer.time_factor == 100:
		set_color($VBoxContainer/ButtonsContainer/x100Button)
	elif Datetimer.time_factor == 10000:
		set_color($VBoxContainer/ButtonsContainer/x10000Button)

func _process(delta):
	if not Engine.is_editor_hint():
		var datetime: Datetime = Saver.data.datetime
		$VBoxContainer/TimerContainer/DateLabel.text = datetime.get_date_str()
		$VBoxContainer/TimerContainer/TimeLabel.text = datetime.get_time_str()

func _input(event):
	if event.is_action_pressed("faster"):
		faster()
	elif event.is_action_pressed("slower"):
		slower()

func faster():
	if Datetimer.time_factor == 1:
		_on_x100_button_pressed()
	elif Datetimer.time_factor == 100:
		_on_x10000_button_pressed()

func slower():
	if Datetimer.time_factor == 100:
		_on_x1_button_pressed()
	elif Datetimer.time_factor == 10000:
		_on_x100_button_pressed()

func set_color(button):
	for node in find_children("*", "Button", true, false):
		node.set("theme_override_colors/font_color", Color.WHITE)
		node.set("theme_override_colors/font_focus_color", Color.WHITE)
	button.set("theme_override_colors/font_color", Color.DARK_RED)
	button.set("theme_override_colors/font_focus_color", Color.DARK_RED)

func _on_x1_button_pressed():
	Datetimer.time_factor = 1.
	set_color($VBoxContainer/ButtonsContainer/x1Button)

func _on_x100_button_pressed():
	Datetimer.time_factor = 100.
	set_color($VBoxContainer/ButtonsContainer/x100Button)

func _on_x10000_button_pressed():
	Datetimer.time_factor = 10000.
	set_color($VBoxContainer/ButtonsContainer/x10000Button)
