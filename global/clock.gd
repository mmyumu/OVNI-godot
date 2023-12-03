extends Node2D

func _process(delta):
	var datetime = Saver.data.datetime.get_datetime()
	$HBoxContainer/DateLabel.text = datetime.get_date_str()
	$HBoxContainer/TimeLabel.text = datetime.get_time_str()
