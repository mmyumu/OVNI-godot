extends Node2D

func _process(delta):
	var datetime = Saver.data.datetime.get_date()
	$HBoxContainer/DateLabel.text = "%d-%02d-%02d" % [datetime.year, datetime.month, datetime.day]
	$HBoxContainer/TimeLabel.text = "%02d:%02d:%02d" % [datetime.hour, datetime.minute, datetime.second]
