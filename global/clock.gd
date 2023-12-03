extends Node2D

func _process(delta):
	var datetime = Saver.data.datetime.get_datetime()
	$VSplitContainer/TimerContainer/DateLabel.text = datetime.get_date_str()
	$VSplitContainer/TimerContainer/TimeLabel.text = datetime.get_time_str()


func _on_x1_button_pressed():
	$Datetimer.time_factor = 1.


func _on_x100_button_pressed():
	$Datetimer.time_factor = 100.


func _on_x10000_button_pressed():
	$Datetimer.time_factor = 10000.
