extends Node

@export var time_factor = 1.0
var previous_date: DatetimeData.Datetime

func _process(delta):
	var new_date: DatetimeData.Datetime = Saver.data.datetime.spent(delta * time_factor)
	if new_date.changed_day(previous_date):
		print("Save because new day")
		Saver.save_data()
	previous_date = new_date
